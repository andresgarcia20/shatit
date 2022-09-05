require "rails_helper"

RSpec.describe DriverRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/driver_requests").to route_to("driver_requests#index")
    end

    it "routes to #my_driver_requests" do
      expect(get: "/users/1/driver_requests").to route_to("driver_requests#my_driver_requests", user_id: "1")
    end

    it "routes to #new" do
      expect(get: "/users/1/driver_requests/new").to route_to("driver_requests#new", user_id: "1")
    end

    it "routes to #show" do
      expect(get: "/users/1/driver_requests/1").to route_to("driver_requests#show", id: "1", user_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/users/1/driver_requests/1/edit").to route_to("driver_requests#edit", id: "1", user_id: "1")
    end


    it "routes to #create" do
      expect(post: "/users/1/driver_requests").to route_to("driver_requests#create", user_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/users/1/driver_requests/1").to route_to("driver_requests#update", id: "1", user_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/users/1/driver_requests/1").to route_to("driver_requests#update", id: "1", user_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/users/1/driver_requests/1").to route_to("driver_requests#destroy", id: "1", user_id: "1")
    end
  end
end
