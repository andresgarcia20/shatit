# # ------------ Users -----------

# 50.times do
#   user = User.new(
#     name: Faker::Name.first_name,
#     surname: Faker::Name.middle_name,
#     nickname: Faker::Internet.username(specifier: 3..10),
#     phone_number: Faker::Number.number(digits: 9),
#     email: Faker::Internet.email,
#     birthday: Faker::Date.birthday(min_age: 18, max_age: 100),
#     password: Faker::Internet.password(min_length: 6),
#   )
#   user.save!
# end

# # ------------- Vehicles ---------------

# Vehicle.create(user_id: 1, model: "Yamaha R6", air_conditioning: false, vehicle_type: "motorbike", consumption: 4.0, nickname: "running")

# Vehicle.create(user_id: 2, model: "Ford Fiesta", air_conditioning: true, vehicle_type: "car", consumption: 4.0, nickname: "partyy")

# Vehicle.create(user_id: 3, model: "Volkswagen Polo", air_conditioning: true, vehicle_type: "car", consumption: 6.4, nickname: "polito")

# Vehicle.create(user_id: 3, model: "Volkswagen Bus", air_conditioning: false, vehicle_type: "van", consumption: 8, nickname: "hippie")

# #--------------- Trips ------------------

# Trip.create(
#   user_id: 1,
#   origin: "MADRID",
#   destinations: ["BARCELONA", "CORDOBA"],
#   available_seats: 1,
#   departure_date: "2022-07-20 12:00:00",
#   vehicle_id: 1,
#   pets: 0,
#   luggage: 0,
#   gasoline_comission: 100,
# )

# Trip.create(
#   user_id: 1,
#   origin: "VALENCIA",
#   destinations: ["GRANADA", "SEVILLA"],
#   available_seats: 1,
#   departure_date: "2022-07-20 12:00:00",
#   vehicle_id: 1,
#   pets: 0,
#   luggage: 0,
#   gasoline_comission: 85,
# )

# Trip.create(
#   user_id: 2,
#   origin: "MALAGA",
#   destinations: ["CADIZ", "BILBAO"],
#   available_seats: 3,
#   departure_date: "2022-07-20 12:00:00",
#   vehicle_id: 2,
#   pets: 1,
#   luggage: 3,
#   gasoline_comission: 150,
# )

# Trip.create(
#   user_id: 2,
#   origin: "MADRID",
#   destinations: ["SALAMANCA", "BILBAO", "BARCELONA"],
#   available_seats: 2,
#   departure_date: "2022-07-20 12:00:00",
#   vehicle_id: 3,
#   pets: 1,
#   luggage: 1,
#   gasoline_comission: 150,
# )

# Trip.create(
#   user_id: 5,
#   origin: "CORDOBA",
#   destinations: ["VALENCIA", "GRANADA"],
#   available_seats: 6,
#   departure_date: "2022-07-20 12:00:00",
#   vehicle_id: 4,
#   pets: 2,
#   luggage: 4,
#   gasoline_comission: 90,
# )

# Trip.create(
#   user_id: 5,
#   origin: "SEVILLE",
#   destinations: ["MALAGA", "CADIZ", "MADRID", "SALAMANCA"],
#   available_seats: 4,
#   departure_date: "2022-07-20 12:00:00",
#   vehicle_id: 4,
#   pets: 0,
#   luggage: 3,
#   gasoline_comission: 120,
# )
