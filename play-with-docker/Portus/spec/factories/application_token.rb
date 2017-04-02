FactoryGirl.define do
  factory :application_token do
    sequence :application do |i|
      "application #{i}"
    end

    # the plain token is application
    token_salt { BCrypt::Engine.generate_salt }
    token_hash { BCrypt::Engine.hash_secret(application, token_salt) }

    association :user, factory: :user
  end
end
