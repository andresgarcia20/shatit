FactoryBot.define do
  sequence(:email) { |n| "email#{n}@cw.com" }
  sequence(:phone_number) { |n| 1231+n+23123 }
  sequence(:nickname) { |n| "user#{n}" }

  factory :user do
    name {"Andrew"}
    surname {"Cheng"}
    email
    phone_number
    nickname
    birthday {"2001-03-20"}
  end

  factory :vehicle do
    model {"Ford Fiesta"}
    air_conditioning {true}
    vehicle_type {"car"}
    consumption {4.50}
    nickname
    user {association :user}
  end
end