require "rails_helper"

RSpec.describe "/companions", type: :request do
  let(:new_user) { create(:user) }
  let(:new_companion) { create(:companion, name: "Poldo") }
  let(:valid_attributes) { attributes_for(:companion) }
  let(:invalid_attributes) { { "id": 1 } }

  describe "GET /index" do
    it "renders a successful response" do
      sign_in new_user
      get user_companions_url(user_id: new_user.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      sign_in new_user
      get user_companion_url(new_companion, user_id: new_user.id)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      sign_in new_user
      get new_user_companion_url(user_id: new_user.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      sign_in new_user
      get edit_user_companion_url(new_companion, id: new_companion.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Companion" do
        sign_in new_user
        expect {
          post user_companions_url(user_id: new_user.id), params: { companion: valid_attributes }
        }.to change(Companion, :count).by(1)
      end

      it "redirects to the created companion" do
        sign_in new_user
        post user_companions_url(user_id: new_user.id), params: { companion: valid_attributes }
        expect(response).to redirect_to(user_companion_url(id: Companion.last.id, user_id: Companion.last.user_id))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Companion" do
        sign_in new_user
        expect {
          post user_companions_url(user_id: new_user.id), params: { companion: invalid_attributes }
        }.to change(Companion, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post user_companions_url(user_id: new_user.id), params: { companion: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { "name" => "Fran" } }

      it "updates the requested companion" do
        sign_in new_user
        patch user_companion_url(id: new_companion.id, user_id: new_user.id), params: { companion: new_attributes }
        new_companion.reload
        expect(new_companion.name).to eq("Fran")
      end

      it "redirects to the companion" do
        sign_in new_user
        patch user_companion_url(id: new_companion.id, user_id: new_user.id), params: { companion: new_attributes }
        new_companion.reload
        expect(response).to redirect_to(user_companion_url(id: new_companion, user_id: new_user.id))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        sign_in new_user
        patch user_companion_url(id: new_companion.id, user_id: new_user.id), params: { companion: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested companion" do
      sign_in new_user
      new_companion
      expect {
        delete user_companion_url(id: new_companion, user_id: new_user.id)
      }.to change(Companion, :count).by(-1)
    end

    it "redirects to the companions list" do
      sign_in new_user
      delete user_companion_url(id: new_companion.id, user_id: new_user.id)
      expect(response).to redirect_to(user_companions_url(new_companion))
    end
  end
end
