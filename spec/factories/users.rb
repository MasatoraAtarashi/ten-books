FactoryBot.define do
  factory :user do
    name "Example"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"

    trait :admin do
      admin true
    end
  end
end
