require 'rails_helper'

describe Vehicle, type: :model do
  describe "validation" do
    before {
      @new_vehicle = create(:vehicle)
    }

    it "returns true when vehicle is valid" do
      expect(@new_vehicle).to be_valid
    end

    it "returns false if model is empty" do
      @new_vehicle.model = nil
      expect(@new_vehicle).to be_invalid
    end

    it "returns false if model length is < 3" do
      @new_vehicle.model = "BM"
      expect(@new_vehicle).to be_invalid
    end
  end
end
