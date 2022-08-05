require "faker"

FactoryBot.define do
  factory :companion do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    phone_number { Faker::Number.number(digits: 9) }
    user_id { create(:user).id }
  end
end
