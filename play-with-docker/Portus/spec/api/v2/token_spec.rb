require "rails_helper"

describe "/v2/token" do
  describe "get token" do
    def parse_token(body)
      token = JSON.parse(body)["token"]
      JWT.decode(token, nil, false, leeway: 2)[0]
    end

    let(:auth_mech) { ActionController::HttpAuthentication::Basic }
    let(:password) { "this is a test" }
    let(:user) { create(:user, password: password) }
    let(:registry) { create(:registry) }

    let(:valid_auth_header) do
      { "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(user.username, password) }
    end

    let(:invalid_auth_header) do
      { "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(user.username, "wrong_password") }
    end

    let(:nonexistent_auth_header) do
      { "HTTP_AUTHORIZATION" => auth_mech.encode_credentials("caesar", "password") }
    end

    context "as invalid user" do
      let(:valid_request) do
        {
          service: registry.hostname,
          account: "account",
          scope:   "repository:foo_namespace/me:push"
        }
      end
      before do
        create(:namespace, name: "foo_namespace", registry: registry)
      end

      it "denies access when the password is wrong" do
        get v2_token_url,
          valid_request,
          invalid_auth_header

        expect(response.status).to eq 401
      end

      it "denies access when the user does not exist" do
        get v2_token_url,
          valid_request,
          nonexistent_auth_header

        expect(response.status).to eq 401
      end

      it "denies access when basic auth credentials are not defined" do
        get v2_token_url, valid_request

        payload = parse_token response.body
        expect(payload["access"]).to be_empty
      end

      it "denies access to a disabled user" do
        user.update_attributes(enabled: false)
        get v2_token_url, valid_request, valid_auth_header
        expect(response.status).to eq 401
      end

      it "allows access when the specified password is a valid application token" do
        token_plain = "plain token"
        create(
          :application_token,
          application: token_plain, # this factory uses application as plain token
          user:        user
        )

        get v2_token_url,
          {
            service: registry.hostname,
            account: user.username,
            scope:   "repository:#{user.username}/busybox:push,pull"
          },
          "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(user.username, token_plain)

        expect(response.status).to eq 200
      end

      it "denies access when cannot find valid application token or password" do
        token_plain = "plain token"
        create(
          :application_token,
          application: token_plain, # this factory uses application as plain token
          user:        user
        )

        get v2_token_url,
          {
            service: registry.hostname,
            account: user.username,
            scope:   "repository:#{user.username}/busybox:push,pull"
          },
          "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(user.username, "wrong")

        expect(response.status).to eq 401
      end
    end

    context "as another user" do
      let(:another) { create(:user, password: password) }

      it "does not allow to pull a private namespace from another team" do
        # It works for the regular user
        get v2_token_url,
          {
            service: registry.hostname,
            account: user.username,
            scope:   "repository:#{user.username}/busybox:push,pull"
          },
          "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(user.username, password)

        expect(response.status).to eq 200
        payload = parse_token response.body
        expect(payload["access"]).not_to be_empty

        # But not for another
        get v2_token_url,
          {
            service: registry.hostname,
            account: another.username,
            scope:   "repository:#{user.username}/busybox:push,pull"
          },
          "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(another.username, password)

        expect(response.status).to eq 200
        payload = parse_token response.body
        expect(payload["access"]).to be_empty
      end

      it "does not allow a regular user to delete an image from another user" do
        scope = "repository:#{user.username}/busybox:*"

        # It works for the regular user
        get v2_token_url,
          {
            service: registry.hostname,
            account: user.username,
            scope:   scope
          },
          "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(user.username, password)

        expect(response.status).to eq 200
        payload = parse_token response.body
        expect(payload["access"]).not_to be_empty

        # But not for another
        get v2_token_url,
          {
            service: registry.hostname,
            account: another.username,
            scope:   scope
          },
          "HTTP_AUTHORIZATION" => auth_mech.encode_credentials(another.username, password)

        expect(response.status).to eq 200
        payload = parse_token response.body
        expect(payload["access"]).to be_empty
      end
    end

    context "as LDAP user I can authenticate from Docker CLI" do
      before :each do
        APP_CONFIG["ldap"] = { "enabled" => true, "base" => "" }
        allow_any_instance_of(Portus::LDAP).to receive(:authenticate!).and_call_original
        allow_any_instance_of(Net::LDAP).to receive(:bind_as).and_return(true)
      end

      it "authenticates if the HTTP Basic Authentication was given" do
        get v2_token_url,
          {
            service: registry.hostname,
            account: "ldapuser"
          },
          "HTTP_AUTHORIZATION" => auth_mech.encode_credentials("ldapuser", "12341234")

        expect(response.status).to eq 200

        # Check that the user has actually been registered.
        ldapuser = User.find_by(username: "ldapuser")
        expect(ldapuser.username).to eq "ldapuser"
        expect(ldapuser.valid_password?("12341234")).to be true
      end
    end

    context "as valid user" do
      let(:valid_request) do
        {
          service: registry.hostname,
          account: "account",
          scope:   "repository:foo_namespace/me:push"
        }
      end

      before do
        allow_any_instance_of(NamespacePolicy).to receive(:push?).and_return(true)
        allow_any_instance_of(NamespacePolicy).to receive(:pull?).and_return(true)
        create(:namespace, name: "foo_namespace", registry: registry)
      end

      it "performs a request with given data" do
        get v2_token_url, valid_request, valid_auth_header
        expect(response.status).to eq 200
      end

      it "decoded payload should conform with params sent" do
        get v2_token_url, valid_request, valid_auth_header
        payload = parse_token response.body
        expect(payload["sub"]).to eq "account"
        expect(payload["aud"]).to eq registry.hostname
        expect(payload["access"][0]["type"]).to eq "repository"
        expect(payload["access"][0]["name"]).to eq "foo_namespace/me"
        expect(payload["access"][0]["actions"][0]).to eq "push"
      end

      context "no scope requested" do
        before do
          get v2_token_url, { service: registry.hostname, account: "account" }, valid_auth_header
        end

        it "respond with 200" do
          expect(response.status).to eq 200
        end

        it "decoded payload should not contain access key" do
          payload = parse_token response.body
          expect(payload).to_not have_key("access")
        end

      end

      context "unknown scope requested" do
        before do
          get v2_token_url,
            { service: registry.hostname, account: "account", scope: "whale:foo,bar" },
            valid_auth_header
        end

        it "respond with 401" do
          expect(response.status).to eq 401
        end
      end

      context "repository scope" do
        it "delegates authentication to the Namespace policy" do
          personal_namespace = user.namespace
          expect_any_instance_of(Api::V2::TokensController).to receive(:authorize)
            .with(personal_namespace, :push?)
          expect_any_instance_of(Api::V2::TokensController).to receive(:authorize)
            .with(personal_namespace, :pull?)

          get v2_token_url,
            {
              service: registry.hostname,
              account: user.username,
              scope:   "repository:#{user.username}/busybox:push,pull"
            },
            valid_auth_header
        end

        it "allows to pull an image in which this user is just a viewer" do
          # Quick way to force a "viewer" policy.
          allow_any_instance_of(NamespacePolicy).to receive(:push?).and_return(false)
          allow_any_instance_of(NamespacePolicy).to receive(:pull?).and_return(true)

          get v2_token_url,
            { service: registry.hostname, account: user.username,
              scope: "repository:#{user.username}/busybox:push,pull" },
            valid_auth_header

          expect(response.status).to eq 200

          # And check that the only authorized scope is "pull"
          payload = parse_token response.body
          expect(payload["access"][0]["name"]).to eq "#{user.username}/busybox"
          expect(payload["access"][0]["actions"]).to match_array ["pull"]
        end
      end

      context "registry scope" do
        let(:valid_request) do
          {
            service: registry.hostname,
            account: "portus",
            scope:   "registry:catalog:*"
          }
        end

        let(:valid_portus_auth_header) do
          {
            "HTTP_AUTHORIZATION" =>
                                    auth_mech.encode_credentials("portus",
                                         Rails.application.secrets.portus_password)
          }
        end

        before do
          User.create!(
            username: "portus",
            password: Rails.application.secrets.portus_password,
            email:    "portus@portus.com",
            admin:    true
          )
        end

        it "allows portus to access the Catalog API" do
          get v2_token_url, valid_request, valid_portus_auth_header
          expect(response.status).to eq 200
          payload = parse_token response.body
          expect(payload["sub"]).to eq "portus"
          expect(payload["aud"]).to eq registry.hostname
          expect(payload["access"][0]["type"]).to eq "registry"
          expect(payload["access"][0]["name"]).to eq "catalog"
          expect(payload["access"][0]["actions"][0]).to eq "*"
        end
      end

      context "unknown scope" do
        it "denies access" do
          get v2_token_url,
              {
                service: registry.hostname,
                account: user.username,
                scope:   "repository:busybox:fork"
              },
              valid_auth_header
          payload = parse_token response.body
          expect(payload["access"]).to be_empty
        end
      end

      context "multiple scopes" do
        it "allows access" do
          query_string = "service=#{registry.hostname}&" \
                         "account=user.username&" \
                         "scope=repository%3Abusybox%3Apush&" \
                         "scope=repository%3Abusybox%3Apull"
          allow_any_instance_of(ActionDispatch::Request).to receive(:query_string)
            .and_return(query_string)
          get v2_token_url, query_string, valid_auth_header
          expect(response.status).to eq 200
          payload = parse_token response.body
          expect(payload["access"].size).to eq(1)
          expect(payload["access"][0]["actions"]).to eq(["push", "pull"])

        end
      end

      context "unknown type" do
        it "denies access" do
          get v2_token_url,
              { service: registry.hostname, account: user.username, scope: "lala:busybox:fork" },
              valid_auth_header
          expect(response.status).to eq 401
        end
      end

      context "unknown registry" do
        context "no scope requested" do
          it "respond with 200 and no access" do
            get v2_token_url, { service: "does not exist", account: "account" }, valid_auth_header
            expect(response.status).to eq 200
            payload = parse_token response.body
            expect(payload["access"]).to be_empty
          end
        end

        context "reposity scope" do
          it "it responds with 200 and no access" do
            # force creation of the namespace
            namespace = create(:namespace,
                               team:     Team.find_by(name: user.username),
                               registry: registry)
            wrong_registry = create(:registry)

            get(
              v2_token_url,
              {
                service: wrong_registry.hostname,
                account: user.username,
                scope:   "repository:#{namespace.name}/busybox:push,pull"
              },
              valid_auth_header
            )
            expect(response.status).to eq(200)
            payload = parse_token response.body
            expect(payload["access"]).to be_empty
          end
        end
      end

    end

  end

end
