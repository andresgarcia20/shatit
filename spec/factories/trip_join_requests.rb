require "faker"

FactoryBot.define do
  factory :trip_join_request do
    companions { 0 }
    pets { 0 }
    luggage { 1 }
    kids { ["no"] }
    stage { "requested" }
    requesters_list { [] }
    trip_id { create(:trip).id }
    user_id { create(:user).id }

    trait :one_companion do
      companions { 1 }
      requesters_list { [{ name: Faker::Name.first_name, surname: Faker::Name.last_name, phone_number: Faker::Number.number(digits: 9) }] }
    end

    trait :three_companion do
      companions { 3 }
    end

    trait :two_pets do
      pets { 2 }
    end

    trait :three_luggage do
      luggage { 3 }
    end

    trait :one_kid do
      kids { ["5 to 12"] }
    end

    trait :two_kid do
      kids { ["5 to 12", "13 to 16"] }
    end

    trait :stage_accepted do
      stage { "accepted" }
    end

    trait :stage_payment_in_progress do
      stage { "payment_in_progress" }
    end

    trait :stage_paid do
      stage { "paid" }
    end

    trait :stage_booked do
      stage { "booked" }
    end

    trait :stage_rejected do
      stage { "rejected" }
    end

    trait :stage_canceled do
      stage { "canceled" }
    end
  end
end
