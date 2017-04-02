# == Schema Information
#
# Table name: application_tokens
#
#  id          :integer          not null, primary key
#  application :string(255)      not null
#  token_hash  :string(255)      not null
#  token_salt  :string(255)      not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_application_tokens_on_user_id  (user_id)
#

require "rails_helper"

describe ApplicationToken do
  context "validator" do
    let(:user) { create(:user) }

    it "checks for the uniqueness of application" do
      create(:application_token, application: "test", user: user)
      expect do
        ApplicationToken.create!(
          application: "test",
          token_hash:  "hash",
          token_salt:  "salt",
          user:        user
        )
      end.to raise_error(ActiveRecord::RecordInvalid, /Application has already been taken/)
    end

    it "allows the same application name to be reaused by different users" do
      create(:application_token, application: "test", user: user)

      user2 = create(:user)
      expect do
        ApplicationToken.create!(
          application: "test",
          token_hash:  "hash",
          token_salt:  "salt",
          user:        user2
        )
      end.not_to raise_error
    end

    it "checks for the number of tokens created by an user" do
      User::APPLICATION_TOKENS_MAX.times do
        create(:application_token, user: user)
      end

      expect do
        ApplicationToken.create!(
          application: "test",
          token_hash:  "hash",
          token_salt:  "salt",
          user:        user
        )
      end.to raise_error(
        ActiveRecord::RecordInvalid,
        /Users cannot have more than #{User::APPLICATION_TOKENS_MAX} application tokens/
      )
    end
  end
end
