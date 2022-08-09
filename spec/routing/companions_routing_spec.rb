require "rails_helper"

RSpec.describe CompanionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users/1/companions").to route_to("companions#index", user_id: "1")
    end

    it "routes to #new" do
      expect(get: "/users/1/companions/new").to route_to("companions#new", user_id: "1")
    end

    it "routes to #show" do
      expect(get: "/users/1/companions/1").to route_to("companions#show", user_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/users/1/companions/1/edit").to route_to("companions#edit", user_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post: "/users/1/companions").to route_to("companions#create", user_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/users/1/companions/1").to route_to("companions#update", user_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/users/1/companions/1").to route_to("companions#update", user_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/users/1/companions/1").to route_to("companions#destroy", user_id: "1", id: "1")
    end
  end
end
