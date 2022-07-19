require "rails_helper"

RSpec.describe TripJoinRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trips/1/trip_join_requests").to route_to("trip_join_requests#index", trip_id: "1")
    end

    it "routes to #new" do
      expect(get: "/trips/1/trip_join_requests/new").to route_to("trip_join_requests#new", trip_id: "1")
    end

    it "routes to #show" do
      expect(get: "/trips/1/trip_join_requests/1").to route_to("trip_join_requests#show", id: "1", trip_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/trips/1/trip_join_requests/1/edit").to route_to("trip_join_requests#edit", id: "1", trip_id: "1")
    end

    it "routes to #create" do
      expect(post: "/trips/1/trip_join_requests").to route_to("trip_join_requests#create", trip_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/trips/1/trip_join_requests/1").to route_to("trip_join_requests#update", id: "1", trip_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trips/1/trip_join_requests/1").to route_to("trip_join_requests#update", id: "1", trip_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/trips/1/trip_join_requests/1").to route_to("trip_join_requests#destroy", id: "1", trip_id: "1")
    end
  end
end
