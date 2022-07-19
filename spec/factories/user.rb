require "faker"

FactoryBot.define do
  factory :user do
    name { "Andrew" }
    surname { "Cheng" }
    email { Faker::Internet.email }
    password { 123456 }
    phone_number { Faker::Number.number(digits: 9) }
    nickname { Faker::Internet.username(specifier: 3..10) }
    birthday { "2001-03-20" }
    confirmed_at { Time.now }
    role { "admin" }

    trait :without_name do
      name { "" }
    end

    trait :without_surname do
      surname { "" }
    end

    trait :custom_email do
      email { "email@test.com" }
    end
  end
end
