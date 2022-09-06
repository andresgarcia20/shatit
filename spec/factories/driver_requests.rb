FactoryBot.define do
  factory :driver_request do
    user_id { create(:user).id }
    driver_licence_front { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_images', 'sad_cat_croc.jpg')) }
    driver_licence_back { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_images', 'sad_cat_croc.jpg')) }
    rejection_reason { "" }

    trait :rejection_reason do
      rejection_reason { "Invalid images." }
    end

    trait :stage_accepted do
      stage { "accepted" }
    end

    trait :stage_rejected do
      stage { "rejected" }
    end
  end
end
