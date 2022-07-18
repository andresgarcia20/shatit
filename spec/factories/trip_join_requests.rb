FactoryBot.define do
  factory :trip_join_request do
    companions { 0 }
    pets { 0 }
    luggage { 1 }
    kids { ["no"] }
    stage { 0 }
    user { association :user }
    trip { association :trip }

    trait :one_companion do
      companions { 1 }
    end

    trait :three_companion do
      companions { 3 }
    end

    trait :two_pets do
      pets { 2 }
    end

    trait :two_luggage do
      luggage { 2 }
    end

    trait :one_kid do
      kids { ["5 to 12"] }
    end

    trait :two_kid do
      kids { ["5 to 12", "13 to 16"] }
    end

    trait :stage_accepted do
      stage { 1 }
    end

    trait :stage_payment_in_progress do
      stage { 2 }
    end

    trait :stage_paid do
      stage { 3 }
    end

    trait :stage_booked do
      stage { 4 }
    end

    trait :stage_rejected do
      stage { 5 }
    end

    trait :stage_cancelled do
      stage { 6 }
    end
  end
end
