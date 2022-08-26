require "rails_helper"

RSpec.describe DriverRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/driver_requests").to route_to("driver_requests#index")
    end

    it "routes to #new" do
      expect(get: "/driver_requests/new").to route_to("driver_requests#new")
    end

    it "routes to #show" do
      expect(get: "/driver_requests/1").to route_to("driver_requests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/driver_requests/1/edit").to route_to("driver_requests#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/driver_requests").to route_to("driver_requests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/driver_requests/1").to route_to("driver_requests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/driver_requests/1").to route_to("driver_requests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/driver_requests/1").to route_to("driver_requests#destroy", id: "1")
    end
  end
end
