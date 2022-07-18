require "rails_helper"

RSpec.describe TripJoinRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trip_join_requests").to route_to("trip_join_requests#index")
    end

    it "routes to #new" do
      expect(get: "/trip_join_requests/new").to route_to("trip_join_requests#new")
    end

    it "routes to #show" do
      expect(get: "/trip_join_requests/1").to route_to("trip_join_requests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/trip_join_requests/1/edit").to route_to("trip_join_requests#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/trip_join_requests").to route_to("trip_join_requests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/trip_join_requests/1").to route_to("trip_join_requests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trip_join_requests/1").to route_to("trip_join_requests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/trip_join_requests/1").to route_to("trip_join_requests#destroy", id: "1")
    end
  end
end
