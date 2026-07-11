require "rails_helper"

# Let's open up some instance variables for testing purposes.
Portus::JwtToken.class_eval { attr_reader :account, :service }

describe Portus::JwtToken do
  let(:mock)     { Portus::JwtToken.new("", "", nil) }
  let(:registry) { create(:registry) }
  let(:scope)    { Namespace::AuthScope.new(registry, "repository:samalba/my-app:push") }

  before do
    allow(scope).to receive(:resource).and_return(double(name: "samalba"))
  end

  describe ".jwt_kid" do
    # TODO: @eotchi add more keys to test against
    it "returns known by libtrust kid of a given key" do
      kid = Portus::JwtToken.kid(mock.private_key)
      expect(kid).to eq "PTWT:FNJE:7TW7:ULI7:DZQA:JJJI:RDJQ:2M76:HD6G:ZRSC:VPIF:O5BU"
    end
  end

  describe "#encoded_token" do
    subject { described_class.new("jlhawn", "registry.docker.com", [scope]) }

    it "calls JWT#encode with claim with stringified_keys" do
      expect(JWT).to receive(:encode).with(
        subject.claim.deep_stringify_keys,
        subject.private_key,
        "RS256",
        "kid" => described_class.kid(subject.private_key)
      )
      subject.encoded_hash
    end
  end

  describe "#private_key" do
    it "returns private key which location is provided by Rails secrets" do
      path = Rails.root.join(Rails.application.secrets.encryption_private_key_path)
      key_contents = File.read(path)
      expect(mock.private_key.to_s).to eq key_contents
    end

    it "returns OpenSSL::PKey::RSA instance" do
      expect(mock.private_key).to be_a_kind_of OpenSSL::PKey::RSA
    end

    it "is private" do
      expect(mock.private_key.private?).to be true
    end
  end

  describe "#claim" do
    subject { described_class.new("jlhawn", "registry.docker.com", [scope]) }

    describe "basic fields" do
      describe ":iss" do
        it "is set to portus fqdn" do
          expect(subject.claim[:iss]).to eq APP_CONFIG["machine_fqdn"]["value"]
        end
      end

      describe ":sub" do
        it "is set to account instance variable" do
          expect(subject.claim[:sub]).to eq subject.account
        end
      end

      describe ":aud" do
        it "is set to service instance variable" do
          expect(subject.claim[:aud]).to eq subject.service
        end
      end

      describe ":exp" do
        it "is set to #expires_at" do
          APP_CONFIG["registry"]["jwt_expiration_time"] = { "value" => "6.minutes" }

          now = Time.zone.now
          expected = now + 6.minutes
          allow(subject).to receive(:issued_at).and_return(now)
          expect(subject.claim[:exp]).to eq expected
        end

        it "uses the default expiration time if nothing is specified" do
          now = Time.zone.now
          expected = now + 5.minutes
          allow(subject).to receive(:issued_at).and_return(now)
          expect(subject.claim[:exp]).to eq expected
        end
      end

      describe ":nbf" do
        it "is set to #not_before" do
          now = Time.zone.now
          allow(subject).to receive(:issued_at).and_return(now)
          expected = now - 5.seconds
          expect(subject.claim[:nbf]).to eq expected
        end
      end

      describe ":iat" do
        it "is set to #not_before" do
          now = Time.zone.now
          allow(subject).to receive(:issued_at).and_return(now)
          expect(subject.claim[:iat]).to eq now
        end
      end

      describe ":jti" do
        it "is set to #jwt_id" do
          fake_jti = SecureRandom.base58(42)
          allow(subject).to receive(:jwt_id).and_return(fake_jti)
          expect(subject.claim[:jti]).to eq fake_jti
        end
      end
    end

    describe "access" do
      it "has type of array" do
        expect(subject.claim[:access]).to be_a_kind_of Array
      end

      it "holds one entity" do
        expect(subject.claim[:access].size).to be 1
      end

      describe ":type" do
        it "has type set to scope#requested_resource_type" do
          expect(subject.claim[:access].first[:type]).to eq scope.resource_type
        end
      end

      describe ":name" do
        it "has name set to scope#requested_resource_name" do
          expect(subject.claim[:access].first[:name]).to eq scope.resource_name
        end
      end

      describe ":actions" do
        it "has actions set to actions from scope" do
          expect(subject.claim[:access].first[:actions]).to eq scope.actions
        end
      end
    end
  end
end
