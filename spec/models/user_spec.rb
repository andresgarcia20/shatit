describe User, type: :model do
  describe "validation" do
    it "returns false when name is empty" do
      expect(User.new(name: nil).valid?).to be false
    end

    it "returns false when name has less than 3 chars" do
      expect(User.new(name: "An").valid?).to be false
    end

    # it "returns true when name does not contains numbers" do
    #   expect(User.new(name: "Andrew20").valid?).to be true
    # end # Uncomment when regex works

    it "returns false when surname is empty" do
      expect(User.new(surname: nil).valid?).to be false
    end

    it "returns true when name and surname are not empty" do
      expect(User.new(name: "Andrew", surname: "La").valid?).to be true
    end

    # xit "returns false when email is empty" do
    #   expect(User.new(email: nil).valid?).to be false
    # end
  end
end
