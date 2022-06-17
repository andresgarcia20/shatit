describe User, type: :model do
  describe "validation" do
    it "returns false when name is empty" do
      expect(User.new(name: nil).valid?).to be false
    end

    it "returns false when name has less than 3 chars" do
      expect(User.new(name: "An").valid?).to be false
    end

    # it "returns true when name does not contains numbers" do
    #   expect(User.new(name: "Andrew").valid?).to be true
    # end

    it "returns false when name is empty" do
      expect(User.new(surname: nil).valid?).to be false
    end
  end
end
