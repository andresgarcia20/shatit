FactoryBot.define do
  factory :trip_join_request do
    companions { 1 }
    pets { 1 }
    luggage { 1 }
    kids { "MyString" }
    stage { 1 }
  end
end
