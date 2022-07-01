FactoryBot.define do
  factory :trip do
    user { association :user }
    origin { "Madrid" }
    destinations { ["Cuenca", "Valencia"] }
    available_seats { 1 }
    departure_date { "2022-06-29 12:00:00" }
    vehicle { association :vehicle }
  end
end
