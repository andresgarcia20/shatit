require "rails_helper"

RSpec.describe "Drivers", type: :request do
  let(:user) { create(:user) }
  describe "GET /index" do
    it "returns http success" do
      sign_in user
      get driver_user_url(user)
      expect(response).to be_successful
    end
  end
end
