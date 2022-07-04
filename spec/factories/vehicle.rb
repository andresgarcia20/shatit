FactoryBot.define do
  factory :vehicle do
    model { "Ford Fiesta" }
    air_conditioning { true }
    vehicle_type { "car" }
    consumption { 4.50 }
    nickname
    user { association :user }
  end
end
