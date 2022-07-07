FactoryBot.define do
  factory :trip do
    user { association :user }
    origin { "Madrid" }
    destinations { ["Cuenca", "Valencia"] }
    available_seats { 1 }
    departure_date { "2022-06-29 12:00:00" }
    vehicle { association :vehicle }
    pets { 1 }
    luggage { 2 }
    kids_age_range { "indifferent" }
    gasoline_comission { 120 }
  end
end
