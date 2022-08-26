# # ------------ Users -----------

50.times do
  user = User.new(
    name: Faker::Name.first_name,
    surname: Faker::Name.middle_name,
    nickname: Faker::Internet.username(specifier: 3..10),
    phone_number: Faker::Number.number(digits: 9),
    email: Faker::Internet.email,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 100),
    password: 123456,
  )
  user.save!
end

# # ------------- Vehicles ---------------

20.times do
  vehicle = Vehicle.new(
    user_id: User.all.sample.id,
    model: Faker::Vehicle.make_and_model,
    air_conditioning: Faker::Boolean.boolean,
    vehicle_type: Vehicle.vehicle_types.keys.sample,
    consumption: 8.00,
    nickname: Faker::Internet.username(specifier: 3..10),
  )
  vehicle.save!
end

# #--------------- Trips ------------------

30.times do
  trip = Trip.new(
    user_id: User.all.sample.id,
    origin: Faker::Address.city,
    destinations: [Faker::Address.city],
    available_seats: Faker::Number.between(from: 1, to: 5),
    departure_date: Faker::Date.in_date_period(month: 12),
    vehicle_id: Vehicle.all.sample.id,
    pets: Faker::Number.between(from: 0, to: 3),
    luggage: Faker::Number.between(from: 1, to: 4),
    gasoline_comission: Faker::Number.between(from: 50, to: 200),
  )
  trip.save!
end
