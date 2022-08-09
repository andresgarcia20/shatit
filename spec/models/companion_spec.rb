describe Companion, type: :model do
  describe "validation" do
    let(:new_companion) { create(:companion, name: "Andrew") }

    it "returns false if name is empty" do
      new_companion.name = nil
      expect(new_companion.valid?).to be false
    end

    it "returns false when name has less than 3 chars" do
      new_companion.name = "An"
      expect(new_companion.valid?).to be false
    end

    it "returns false when name contains numbers" do
      new_companion.name = "Andrew20"
      expect(new_companion.valid?).to be false
    end

    it "returns false when surname is empty" do
      new_companion.surname = nil
      expect(new_companion.valid?).to be false
    end

    it "returns true when surname is not empty" do
      expect(new_companion.valid?).to be true
    end

    it "returns false when surname contains numbers" do
      new_companion.name = "Cheng20"
      expect(new_companion.valid?).to be false
    end

    it "returns false when phone number is empty" do
      new_companion.phone_number = nil
      expect(new_companion.valid?).to be false
    end

    it "returns false if it's not digits" do
      new_companion.phone_number = "asd"
      expect(new_companion.valid?).to be false
    end

    it "returns true if it's only digits" do
      expect(new_companion.valid?).to be true
    end

    it "returns false if it's only one digit" do
      new_companion.phone_number = 2
      expect(new_companion.valid?).to be false
    end

    it "returns false eif it's more than 20 digits" do
      new_companion.phone_number = 123123123123123123123
      expect(new_companion.valid?).to be false
    end

    it "checks phone number uniqueness" do
      user2 = build(:companion, phone_number: new_companion.phone_number)
      expect(user2).to be_invalid
    end
  end
end
