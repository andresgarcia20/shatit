# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# ------------ Users -----------
# ADMIN
# User.create(name: "Andrés", surname: "García", nickname: "drewan", phone_number: 123123123, email: "andres@cw.com", birthday: "2001/03/20", role: "admin")

# # DRIVER
# User.create(name: "Paco", surname: "Perez", nickname: "paquirrin", phone_number: 123123124, email: "paco@cw.com", birthday: "1990/01/02", role: "driver")

# # PASSENGER
# User.create(name: "Sara", surname: "Puertas", nickname: "sarinha", phone_number: 123123125, email: "sara@cw.com", birthday: "2001/03/20")

# # BANNED
# User.create(name: "Fer", surname: "Cheng", nickname: "fer123", phone_number: 123123126, email: "fer@cw.com", birthday: "2001/03/20", role: "banned")

# ------------- Vehicles ---------------

# # Vehicle for user_id = 1
# Vehicle.create(user_id: 1, model: "Yamaha R6", air_conditioning: false, vehicle_type: "motorbike", consumption: 4.0, nickname: "running")

# # Vehicle for user_id = 2
# Vehicle.create(user_id: 2, model: "Ford Fiesta", air_conditioning: true, vehicle_type: "car", consumption: 4.0, nickname: "partyy")

# # Vehicle for user_id = 4
# Vehicle.create(user_id: 4, model: "Volkswagen Polo", air_conditioning: true, vehicle_type: "car", consumption: 6.4, nickname: "polito")
