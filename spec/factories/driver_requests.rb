FactoryBot.define do
  factory :driver_request do
    user { nil }
    driver_licence_front { "MyString" }
    driver_licence_back { "MyString" }
  end
end
