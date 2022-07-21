require "faker"

FactoryBot.define do
  factory :vehicle do
    model { "Ford Fiesta" }
    air_conditioning { true }
    vehicle_type { "car" }
    consumption { 4.50 }
    nickname { Faker::Internet.username(specifier: 3..10) }
    user { build(:user) }
  end
end
