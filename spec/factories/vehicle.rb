require "faker"

FactoryBot.define do
  factory :vehicle do
    model { "Ford Fiesta" }
    air_conditioning { true }
    vehicle_type { "car" }
    consumption { 4.50 }
    nickname { Faker::Internet.username(specifier: 3..10) }
    user { build(:user) }
    insurance { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_images', 'sad_cat_croc.jpg')) }
    car_revision { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_images', 'sad_cat_croc.jpg')) }
  end
end
