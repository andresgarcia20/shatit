require 'rails_helper'

RSpec.describe "/companions", type: :request do

  let(:new_user) { create(:user) }
  let(:new_companion) { create(:companion) }
  let(:valid_attributes) { attributes_for(:companion) }
  let(:invalid_attributes) { { "id": 1 } }

  describe "GET /index" do
    it "renders a successful response" do
      sign_in new_user
      get companions_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      sign_in new_user
      get companion_url(new_companion)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      sign_in new_user
      get new_companion_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      sign_in new_user
      get edit_companion_url(new_companion)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Companion" do
        sign_in new_user
        expect {
          post companions_url, params: { companion: valid_attributes }
        }.to change(Companion, :count).by(1)
      end

      it "redirects to the created companion" do
        sign_in new_user
        post companions_url, params: { companion: valid_attributes }
        expect(response).to redirect_to(companion_url(Companion.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Companion" do
        sign_in new_user
        expect {
          post companions_url, params: { companion: invalid_attributes }
        }.to change(Companion, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post companions_url, params: { companion: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { {"name" => "Fran"} }

      it "updates the requested companion" do
        sign_in new_user
        patch companion_url(new_companion), params: { companion: new_attributes }
        new_companion.reload
        expect(new_companion.name).to eq("Fran")
      end

      it "redirects to the companion" do
        sign_in new_user
        patch companion_url(new_companion), params: { companion: new_attributes }
        new_companion.reload
        expect(response).to redirect_to(companion_url(new_companion))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        sign_in new_user
        patch companion_url(new_companion), params: { companion: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested companion" do
      sign_in new_user
      new_companion
      expect {
        delete companion_url(new_companion)
      }.to change(Companion, :count).by(-1)
    end

    it "redirects to the companions list" do
      sign_in new_user
      new_companion
      delete companion_url(new_companion)
      expect(response).to redirect_to(companions_url)
    end
  end
end
