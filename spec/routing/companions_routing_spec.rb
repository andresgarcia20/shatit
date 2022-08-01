require "rails_helper"

RSpec.describe CompanionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/companions").to route_to("companions#index")
    end

    it "routes to #new" do
      expect(get: "/companions/new").to route_to("companions#new")
    end

    it "routes to #show" do
      expect(get: "/companions/1").to route_to("companions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/companions/1/edit").to route_to("companions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/companions").to route_to("companions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/companions/1").to route_to("companions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/companions/1").to route_to("companions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/companions/1").to route_to("companions#destroy", id: "1")
    end
  end
end
