require 'rails_helper'

describe Vehicle, type: :model do
  describe "validation" do
    before { @new_vehicle = create(:vehicle) }

    it "returns true if Vehicle belongs to User" do
      t = Vehicle.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

    it "returns true when vehicle is valid" do
      expect(@new_vehicle).to be_valid
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

    it "returns false when nickname is empty" do
      @new_vehicle.nickname = nil
      expect(@new_vehicle).to be_invalid
    end

    it "returns false if nickname length is < 2" do
      @new_vehicle.nickname = "a"
      expect(@new_vehicle).to be_invalid
    end

    it "returns false if nickname length is > 10" do
      @new_vehicle.nickname = "asdasdasd22"
      expect(@new_vehicle).to be_invalid
    end

    it "returns false if insurance is blank" do
      @new_vehicle.insurance = nil
      expect(@new_vehicle).to be_invalid
    end

    it "returns false if car_revision is blank" do
      @new_vehicle.car_revision = nil
      expect(@new_vehicle).to be_invalid
    end
  end
end
