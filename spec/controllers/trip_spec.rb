require "rails_helper"
RSpec.describe TripsController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe "GET 'index'" do
    let(:user) { create(:user) }
    let(:vehicle) { create(:vehicle, user: user) }
    let(:second_vehicle) { create(:vehicle, vehicle_type: "van", user: user) }
    let!(:first_trip) { create(:trip, user: user, vehicle: vehicle) }
    let!(:trip_origin_valencia) { create(:trip, user: user, vehicle: vehicle, origin: "valencia") }
    let!(:trip_origin_barcelona) { create(:trip, user: user, vehicle: vehicle, origin: "Barcelona") }
    let!(:trip_three_destinations) { create(:trip, user: user, vehicle: vehicle, destinations: ["Cuenca", "Valencia", "Barcelona"]) }
    let!(:trip_vehicle_type) { create(:trip, user: user, vehicle: second_vehicle) }
    let!(:trip_three_available_seats) { create(:trip, user: user, vehicle: vehicle, available_seats: 3) }
    let!(:trip_user) { create(:trip, user: user, vehicle: vehicle) }
    before { sign_in user }

    context "when there are no filters" do
      before { get :index }

      it "assigns @trips" do
        expect(assigns(:trips).count).to eq(7)
      end

      it "assigns all @trips" do
        expect(assigns(:trips).map(&:id)).to eq([
          first_trip.id,
          trip_origin_valencia.id, 
          trip_origin_barcelona.id,
          trip_three_destinations.id,
          trip_vehicle_type.id,
          trip_three_available_seats.id,
          trip_user.id
          ])
      end
    end

    context "filters by origin = madrid" do
      before { get :index, params: { origin: "madrid" } } 

      it "assigns @trips" do
        expect(assigns(:trips).map(&:id)).to eq([
        first_trip.id,
        trip_three_destinations.id,
        trip_vehicle_type.id,
        trip_three_available_seats.id,
        trip_user.id
        ])
      end
    end

    context "filters by origin = valencia" do
      before { get :index, params: { origin: "valencia" } }

      it { expect(assigns(:trips).map(&:id)).to eq([trip_origin_valencia.id]) }
    end

    context "filters by origin = barcelona" do
      before { get :index, params: { origin: "barcelona" } }

      it { expect(assigns(:trips).map(&:id)).to eq([trip_origin_barcelona.id]) }
    end

    context "filters by destinations = barcelona" do
      before { get :index, params: { destination: "barcelona" } }
      it { expect(assigns(:trips).map(&:id)).to eq([trip_three_destinations.id]) }
    end

    context "filters by number of stops = 2" do
      before { get :index, params: { stops: 2 } }
      xit {
        binding.pry
         expect(assigns(:trips).map(&:id)).to eq([trip_three_destinations.id]) }
    end

    context "filters by available vehicle type = van" do
      before { get :index, params: { type: 1 } }
      it { expect(assigns(:trips).map(&:id)).to eq([trip_vehicle_type.id]) }
    end

    context "filters by available seats = 3" do
      before { get :index, params: { seats: 3 } }
      it { expect(assigns(:trips).map(&:id)).to eq([trip_three_available_seats.id]) }
    end
  end
end
