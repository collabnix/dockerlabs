FactoryGirl.define do
  factory :tag do
    sequence :name do |n|
      "tag#{n}"
    end
    repository
  end
end
