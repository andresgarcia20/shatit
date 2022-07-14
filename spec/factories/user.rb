FactoryBot.define do
  sequence(:email) { |n| "email#{n}@cw.com" }
  sequence(:phone_number) { |n| 1231 + n + 23123 }
  sequence(:nickname) { |n| "user#{n}" }

  factory :user do
    name { "Andrew" }
    surname { "Cheng" }
    email
    password { 123456 }
    phone_number
    nickname
    birthday { "2001-03-20" }
    confirmed_at { Time.now }
    role { "admin" }

    trait :without_name do
      name { "" }
    end

    trait :without_surname do
      surname { "" }
    end
  end
end
