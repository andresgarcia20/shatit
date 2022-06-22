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

    it "returns false if air_conditioning is empty" do
      @new_vehicle.air_conditioning = nil
      expect(@new_vehicle).to be_invalid
    end

    # it "returns true if air_conditioning receives a boolean" do
    #   @new_vehicle.air_conditioning = "hola"
    #   expect(@new_vehicle).to be_invalid
    # end # Fix: check if value receive is boolean, not truthy of falsy

    it "returns false if consumption is empty" do
      @new_vehicle.consumption = nil
      expect(@new_vehicle).to be_invalid
    end

    it "returns false if consumption does not receive a float" do
      @new_vehicle.consumption = "1a"
      expect(@new_vehicle).to be_invalid
    end

    it "returns false if consumption is not greater than 0" do
      @new_vehicle.consumption = -5.2
      expect(@new_vehicle).to be_invalid
    end
  end
end
