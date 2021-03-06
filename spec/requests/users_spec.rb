require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/users", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.

  let(:user_attr) { create(:user) }
  let(:valid_attributes) { attributes_for(:user) }
  let(:invalid_attributes) { { "id" => 1 } }

  describe "GET /index" do
    it "renders a successful response" do
      sign_in user_attr
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      sign_in user_attr
      get user_url(user_attr)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      sign_in user_attr
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      sign_in user_attr
      get edit_user_url(user_attr)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post users_url, params: { user: { **valid_attributes, name: "Fer" } }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        sign_in user_attr
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        sign_in user_attr
        post users_url, params: { user: invalid_attributes }
        expect(response).not_to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { "name" => "Andreq",
          "surname" => "Li",
          "nickname" => "drewan3",
          "phone_number" => 1231231245,
          "email" => "andres3@cw.com",
          "password" => 123456,
          "birthday" => "2000-01-01",
          "confirmed_at" => "2022-07-06 14:58:40.220053" }
      }

      it "updates the requested user" do
        sign_in user_attr
        patch user_url(user_attr), params: { user: new_attributes }
        user_attr.reload
        expect(user_attr.name).to eq("Andreq")
      end

      it "redirects to the user" do
        sign_in user_attr
        patch user_url(user_attr), params: { user: new_attributes }
        user_attr.reload
        expect(response).to redirect_to(user_url(user_attr))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        sign_in user_attr
        patch user_url(user_attr), params: { user: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      sign_in user_attr
      expect {
        delete user_url(user_attr)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      sign_in user_attr
      delete user_url(user_attr)
      expect(response).to redirect_to(users_url)
    end
  end
end
