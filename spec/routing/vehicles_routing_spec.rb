require "rails_helper"

RSpec.describe VehiclesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users/1/vehicles").to route_to("vehicles#index", user_id: "1")
    end

    it "routes to #new" do
      expect(get: "/users/1/vehicles/new").to route_to("vehicles#new", user_id: "1")
    end

    it "routes to #show" do
      expect(get: "/users/1/vehicles/1").to route_to("vehicles#show", user_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/users/1/vehicles/1/edit").to route_to("vehicles#edit", user_id: "1", id: "1")
    end


    it "routes to #create" do
      expect(post: "/users/1/vehicles").to route_to("vehicles#create", user_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/users/1/vehicles/1").to route_to("vehicles#update", user_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/users/1/vehicles/1").to route_to("vehicles#update", user_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/users/1/vehicles/1").to route_to("vehicles#destroy", user_id: "1", id: "1")
    end
  end
end
