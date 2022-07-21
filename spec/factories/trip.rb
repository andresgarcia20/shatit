require "faker"

FactoryBot.define do
  factory :trip do
    user { build(:user) }
    origin { "Madrid" }
    destinations { ["Cuenca", "Valencia"] }
    available_seats { 1 }
    departure_date { Faker::Date.between(from: 1.day.from_now, to: 6.months.from_now) }
    vehicle { build(:vehicle) }
    pets { 1 }
    luggage { 2 }
    kids_age_range { "indifferent" }
    gasoline_comission { 120 }

    trait :three_available_seats do
      available_seats { 3 }
    end

    trait :four_available_seats do
      available_seats { 4 }
    end
  end
end
