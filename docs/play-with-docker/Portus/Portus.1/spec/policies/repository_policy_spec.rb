require "rails_helper"

describe RepositoryPolicy do
  subject { described_class }

  let(:registry)    { create(:registry) }
  let(:user)        { create(:user) }
  let(:user2)       { create(:user) }
  let(:team)        { create(:team, owners: [user]) }
  let(:team2)       { create(:team, owners: [user2]) }

  permissions :show? do
    before :each do
      public_namespace = create(
        :namespace,
        team:       team2,
        visibility: Namespace.visibilities[:visibility_public],
        registry:   registry
      )
      @public_repository = create(:repository, namespace: public_namespace)

      protected_namespace = create(
        :namespace,
        team:       team2,
        visibility: Namespace.visibilities[:visibility_protected],
        registry:   registry
      )
      @protected_repository = create(:repository, namespace: protected_namespace)

      private_namespace = create(:namespace, team: team2, registry: registry)
      @private_repository = create(:repository, namespace: private_namespace)
    end

    it "grants access if the user is an admin" do
      admin = create(:admin)
      testing_repositories = [@public_repository, @private_repository]
      testing_repositories.each do |repository|
        expect(subject).to permit(admin, repository)
      end
    end

    it "grants access if the namespace is public" do
      expect(subject).to permit(user, @public_repository)
    end

    it "grants access if the namespace is protected" do
      expect(subject).to permit(user, @protected_repository)
    end

    it "grants access if the repository belongs to a namespace of a team member" do
      user3 = create(:user)
      TeamUser.create(team: team2, user: user3, role: TeamUser.roles["viewer"])
      expect(subject).to permit(user3, @private_repository)
    end

    it "denies access if repository is private and the user is no team member or an admin" do
      expect(subject).to_not permit(user, @private_repository)
    end
  end

  permissions :destroy? do
    before :each do
      public_namespace = create(
        :namespace,
        team:       team2,
        visibility: Namespace.visibilities[:visibility_public],
        registry:   registry
      )
      @public_repository = create(:repository, namespace: public_namespace)

      protected_namespace = create(
        :namespace,
        team:       team2,
        visibility: Namespace.visibilities[:visibility_protected],
        registry:   registry
      )
      @protected_repository = create(:repository, namespace: protected_namespace)

      private_namespace = create(:namespace, team: team2, registry: registry)
      @private_repository = create(:repository, namespace: private_namespace)
    end

    it "grants access if the user is an admin" do
      admin = create(:admin)
      testing_repositories = [@public_repository, @private_repository]
      testing_repositories.each do |repository|
        expect(subject).to permit(admin, repository)
      end
    end

    it "denies access if the namespace is public" do
      expect(subject).to_not permit(user, @public_repository)
    end

    it "denies access if the namespace is protected" do
      expect(subject).to_not permit(user, @protected_repository)
    end

    it "grants access if the repository belongs to a namespace of a team member" do
      user3 = create(:user)
      TeamUser.create(team: team2, user: user3, role: TeamUser.roles["viewer"])
      expect(subject).to_not permit(user3, @private_repository)
      TeamUser.find_by(team: team2, user: user3).update_attributes(role: TeamUser.roles["owner"])
      expect(subject).to permit(user3, @private_repository)
    end

    it "denies access if repository is private and the user is no team member or an admin" do
      expect(subject).to_not permit(user, @private_repository)
    end
  end

  describe "scope" do
    before :each do
      public_namespace = create(
        :namespace,
        team:       team2,
        visibility: Namespace.visibilities[:visibility_public],
        registry:   registry
      )
      @public_repository = create(:repository, namespace: public_namespace)

      private_namespace = create(:namespace, team: team2, registry: registry)
      @private_repository = create(:repository, namespace: private_namespace)

      namespace = create(:namespace, team: team, registry: registry)
      @repository = create(:repository, namespace: namespace)
    end

    it "include repositories that are part of public namespaces" do
      expect(Pundit.policy_scope(user, Repository).to_a).to include(@public_repository)
    end

    it "include repositories that are part of namespace controlled by a team to which " \
      "the user belongs" do

      expect(Pundit.policy_scope(user, Repository).to_a).to include(@repository)
    end

    it "never shows repositories inside of private namespaces" do
      expect(Pundit.policy_scope(user, Repository).to_a).not_to include(@private_repository)
    end
  end

  describe "search" do
    let!(:namespace)  { create(:namespace, team: team, name: "mssola") }
    let!(:repository) { create(:repository, namespace: namespace, name: "repository") }

    it "finds the same repository regardless to how it has been written" do
      %w(repository rep epo).each do |name|
        repo = Pundit.policy_scope(user, Repository).search(name)
        expect(repo.name).to eql "Repository"
      end
    end

    it "finds repos with the `repo:tag` syntax" do
      %w(repository rep epo).each do |name|
        name = "#{name}:tag"
        repo = Pundit.policy_scope(user, Repository).search(name)
        expect(repo.name).to eql "Repository"
      end
    end
  end
end
