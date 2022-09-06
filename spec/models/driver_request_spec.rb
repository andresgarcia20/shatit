require 'rails_helper'

RSpec.describe DriverRequest, type: :model do
  describe "model" do
    let(:user) { create(:user) }
    let!(:driver_request) { create(:driver_request, user_id: user.id) }

    context "validation" do
      it "returns true if the driver request has all permited params" do
        expect(driver_request.valid?).to be true
      end

      context "driver_licence_front" do
        it "returns false if is blank" do
          driver_request.driver_licence_front = nil
          expect(driver_request.valid?).to be false
        end
      end

      context "driver_licence_back" do
        it "returns false if is blank" do
          driver_request.driver_licence_back = nil
          expect(driver_request.valid?).to be false
        end
      end

      context "stage" do
        it "returns true if 'requested' is the default stage" do
          expect(DriverRequest.new.stage).to eq(driver_request.stage)
        end
      end
    end

    context "scopes" do
      context "by_user" do
        it "returns driver request by given user" do
          expect(DriverRequest.by_user(user.id).map(&:id)).to eq([driver_request.id])
        end
      end

      context "by_requested" do
        it "returns driver request by stage requested" do
          expect(DriverRequest.by_user(user.id).by_requested.map(&:id)).to eq([driver_request.id])
        end
      end

      context "by_accepted" do
        let!(:accepted_driver_request) { create(:driver_request, :stage_accepted, user_id: user.id) }

        it "returns driver request by given user" do
          expect(DriverRequest.by_user(user.id).by_accepted.map(&:id)).to eq([accepted_driver_request.id])
        end
      end

      context "by_rejected" do
        let!(:rejected_driver_request) { create(:driver_request, :stage_rejected, user_id: user.id) }

        it "returns driver request by given user" do
          expect(DriverRequest.by_user(user.id).by_rejected.map(&:id)).to eq([rejected_driver_request.id])
        end
      end
    end
  end
end
