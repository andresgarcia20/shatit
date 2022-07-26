FactoryBot.define do
  factory :trip_join_request do
    companions { 0 }
    pets { 0 }
    luggage { 1 }
    kids { ["no"] }
    stage { 0 }
    trip_id { create(:trip).id }
    user_id { create(:user).id }

    trait :one_companion do
      companions { 1 }
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
      stage { 10 }
    end

    trait :stage_payment_in_progress do
      stage { 20 }
    end

    trait :stage_paid do
      stage { 30 }
    end

    trait :stage_booked do
      stage { 40 }
    end

    trait :stage_rejected do
      stage { 50 }
    end

    trait :stage_canceled do
      stage { 60 }
    end
  end
end
