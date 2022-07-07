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
  end

  describe "scope" do
    before do
      travel_to Time.zone.local(2022, 06, 28)
      @trip = create(:trip)
    end

    it "by_origin returns info by given origin" do
      expect(Trip.by_origin("madrid")).to eq([@trip])
    end

    it "by_destination returns info by given destination" do
      expect(Trip.by_destination("valencia")).to eq([@trip])
    end

    it "by_number_of_stops returns info by given stops" do
      expect(Trip.by_number_of_stops(1).count).to eq(@trip.number_of_stops)
    end

    xit "by_vehicle returns info by given type of vehicle" do
      expect(Trip.by_vehicle(4)).to include(@trip.vehicle)
    end

    it "by_free_seats returns info by given number of free seats" do
      expect(Trip.by_free_seats(1)).to eq([@trip])
    end

    xit "by_user returns info by given user" do
      expect(Trip.by_user()).to eq([@trip])
    end
  end
end
