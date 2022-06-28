describe User, type: :model do
  describe "validation" do
    include ActiveSupport::Testing::TimeHelpers

    before { @new_trip = create(:trip) }

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
      before do
        travel_to Time.zone.local(2022, 06, 28)
        @new_trip.departure_date = Time.zone.parse(dep_date).to_date
      end

      context "when date has already past" do
        let(:dep_date) { "2022-06-27" }
        it { expect(@new_trip.correct_date?).to be false }
      end

      context "when date is correct" do
        let(:dep_date) { "2022-06-30" }
        it { expect(@new_trip.correct_date?).to be true }
      end
    end
  end
end
