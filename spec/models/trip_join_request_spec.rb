require "rails_helper"

RSpec.describe TripJoinRequest, type: :model do
  describe "model" do
    let(:trip_request) { create(:trip_join_request) }
    let(:trip) { create(:trip) }

    context "validation" do
      it "returns true if trip join request has all permited params" do
        expect(trip_request.valid?).to be true
      end

      context "companions" do
        it "returns true if positive numbers are introduced" do
          expect(trip_request.valid?).to be true
        end

        it "returns false if negative numbers are introduced" do
          trip_request.companions = -3
          expect(trip_request.valid?).to be false
        end

        it "returns false if no numbers are introduced" do
          trip_request.companions = "a"
          expect(trip_request.valid?).to be false
        end

        it "returns true if number of companions plus coordinator is equal or less than available seats" do
          trip_request.companions = 2
          expect(trip_request.companions + 1).to be <= build(:trip, :three_available_seats).available_seats
        end

        it "returns false if number of companions plus coordinator is more than available seats" do
          trip_request.companions = 3
          expect(trip_request.companions + 1).not_to be <= trip.available_seats
        end

        context "returns true if the number of available seats decreases depending of number of companions" do
          before do
            @trip = create(:trip, :four_available_seats)
            @trip_request = create(:trip_join_request, :three_companion, trip: trip)
          end

          it { expect(@trip_request.trip.available_seats - 1).to eq(0) }
        end
      end

      context "pets" do
        it "returns true if positive numbers are introduced" do
          expect(trip_request.valid?).to be true
        end

        it "returns false if negative numbers are introduced" do
          trip_request.pets = -3
          expect(trip_request.valid?).to be false
        end

        it "returns false if no numbers are introduced" do
          trip_request.pets = "a"
          expect(trip_request.valid?).to be false
        end

        it "returns true if number of pets is equal or less than pets admited" do
          trip_request.pets = 1
          expect(trip_request.pets).to be <= trip.pets
        end

        it "returns false if number of pets is more than pets admited" do
          expect(build(:trip_join_request, :two_pets).pets).to be > trip.pets
        end
      end

      context "luggage" do
        it "returns true if positive numbers are introduced" do
          expect(trip_request.valid?).to be true
        end

        it "returns false if negative numbers are introduced" do
          trip_request.luggage = -3
          expect(trip_request.valid?).to be false
        end

        it "returns false if no numbers are introduced" do
          trip_request.luggage = "a"
          expect(trip_request.valid?).to be false
        end

        it "returns true if number of luggage is equal or less than luggage admited" do
          trip_request.luggage = 1
          expect(trip_request.luggage).to be <= trip.luggage
        end

        it "returns false if number of luggage is more than admited" do
          expect(build(:trip_join_request, :three_luggage).luggage).to be > trip.luggage
        end
      end

      context "kids" do
        it "returns false if the input is empty" do
          expect(trip_request.kids.size).to be > 0
        end
      end
    end
  end
end
