describe User, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  describe "validation" do
    before do
      travel_to Time.zone.local(2022, 06, 28)
      @new_trip = create(:trip)
    end

    it "returns true when trip is valid" do
      expect(@new_trip.valid?).to be true
    end

    it "returns false if origin is empty" do
      @new_trip.origin = nil
      expect(@new_trip.valid?).to be false
    end

    it "returns false if destinations is empty" do
      @new_trip.destinations = nil
      expect(@new_trip.valid?).to be false
    end

    it "returns false if destinations size = 0" do
      @new_trip.destinations = []
      expect(@new_trip.valid?).to be false
    end

    it "returns true if destinations size > 0" do
      @new_trip.destinations = ["Valencia"]
      expect(@new_trip.valid?).to be true
    end

    it "returns false if destinations size > 9" do
      @new_trip.destinations = ["Valencia", "Barcelona", "Sevilla", "Toledo", "Granada", "Málaga", "Zaragoza", "Córdoba", "Bilbao", "Salamanca"]
      expect(@new_trip.valid?).to be false
    end

    it "returns false if destinations size >= 9" do
      @new_trip.destinations = ["Valencia", "Barcelona", "Toledo", "Granada", "Málaga", "Zaragoza", "Córdoba", "Bilbao", "Salamanca"]
      expect(@new_trip.valid?).to be true
    end

    it "returns false if available_seats is empty" do
      @new_trip.available_seats = nil
      expect(@new_trip.valid?).to be false
    end

    it "returns false if available_seats is 0" do
      @new_trip.available_seats = 0
      expect(@new_trip.valid?).to be false
    end

    it "returns false if available_seats is not a number" do
      @new_trip.available_seats = "hola"
      expect(@new_trip.valid?).to be false
    end

    context "verifying correct departure date" do
      before { @new_trip.departure_date = Time.zone.parse(dep_date).to_date }

      context "when date has already past" do
        let(:dep_date) { "2022-06-27" }
        it { expect(@new_trip.date_valid?).to be false }
      end

      context "when date is correct" do
        let(:dep_date) { "2022-06-30" }
        it { expect(@new_trip.date_valid?).to be true }
      end
    end

    it "when a trip is created, its initial status is in_preparation" do
      expect(@new_trip.trip_status).to eq("in_preparation")
    end
  end

  describe "scope" do
    before do
      travel_to Time.zone.local(2022, 06, 28)
      @trip = create(:trip, departure_date: "2022-06-29")
      @second_trip = create(:trip, departure_date: "2022-07-10")
      @third_trip = create(:trip, departure_date: "2022-07-20")
      @fourth_trip = create(:trip, departure_date: "2022-07-29")
    end

    it "by_origin returns info by given origin" do
      expect(Trip.by_origin("madrid")).to eq([@trip, @second_trip, @third_trip, @fourth_trip])
    end

    it "by_destination returns info by given destination" do
      expect(Trip.by_destination("valencia")).to eq([@trip, @second_trip, @third_trip, @fourth_trip])
    end

    it "by_number_of_stops returns info by given stops" do
      expect(Trip.by_number_of_stops(1).count).to eq(4)
    end

    it "by_vehicle returns info by given type of vehicle" do
      expect(Trip.by_vehicle(0).map(&:vehicle_id)).to eq([@trip.vehicle_id, @second_trip.vehicle_id, @third_trip.vehicle_id, @fourth_trip.vehicle_id])
    end

    it "by_free_seats returns info by given number of free seats" do
      expect(Trip.by_free_seats(1)).to eq([@trip, @second_trip, @third_trip, @fourth_trip])
    end

    it "by_user returns info by given user" do
      expect(Trip.by_user(@trip.user_id)).to eq([@trip])
    end

    it "trips_date_range returns info in a date range between 2022-06-29 and 2022-07-20" do
      expect(Trip.trips_date_range("2022-06-28", "2022-07-20")).to eq([@trip, @second_trip, @third_trip])
    end

    it "trips_date_range returns trips with only start_date" do
      expect(Trip.trips_date_range("2022-07-01", "")).to eq([@second_trip, @third_trip, @fourth_trip])
    end

    it "trips_date_range returns trips with only end_date" do
      expect(Trip.trips_date_range("", "2022-07-01")).to eq([@trip])
    end

    it "trips_todo returns trips yet to come" do
      expect(Trip.trips_todo.map(&:id)).to eq([@trip.id, @second_trip.id, @third_trip.id, @fourth_trip.id])
    end
  end

  context "when a trip finalize" do
    let(:first_trip) { create(:trip) }
    let(:second_trip) { create(:trip) }
    let(:first_request) { create(:trip_join_request, :stage_paid, trip_id: first_trip.id) }
    let(:second_request) { create(:trip_join_request, :one_companion, :stage_paid, trip_id: second_trip.id) }

    it "the status change to finalized" do
      first_request
      first_trip.finalized!
      expect(first_trip.trip_status).to eq("finalized")
    end

    it "if there is no companions, only copy the requester" do
      requester = first_request.user
      first_trip.finalized!
      expect(first_trip.passengers_list).to eq([{ "name" => requester.name, "surname" => requester.surname, "phone_number" => requester.phone_number }])
    end

    it "it denormalize and copy the information into the trip" do
      coordinator = second_request.user
      second_trip.finalized!
      expect(second_trip.passengers_list).to eq([{ "name" => coordinator.name, "surname" => coordinator.surname, "phone_number" => coordinator.phone_number }, *second_request.requesters_list])
    end
  end
end
