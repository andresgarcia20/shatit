describe User, type: :model do
  describe "validation" do
    let(:newUser) {
      User.new(
      name: "Andrew",
      surname: "Cheng",
      email: "andrew@cw.com",
      phone_number: 123131313,
      nickname: "drewan",
      age: 21
    )}

    it "returns false when name is empty" do
      newUser.name = nil
      expect(newUser.valid?).to be false
    end

    it "returns false when name has less than 3 chars" do
      newUser.name = "An"
      expect(newUser.valid?).to be false
    end

    # it "returns true when name does not contains numbers" do
    #   expect(newUser.new(name: "Andrew20").valid?).to be true
    # end # Uncomment when regex works

    it "returns false when surname is empty" do
      newUser.surname = nil
      expect(newUser.valid?).to be false
    end

    it "returns true when surname is not empty" do
      expect(newUser.valid?).to be true
    end

    it "returns false when email is empty" do
      newUser.email = nil
      expect(newUser.valid?).to be false
    end

    it "returns true if it's a valid email format" do
      newUser.email = "andres@andres.com"
      expect(newUser.valid?).to be true
    end

    it "returns false if it contains blank spaces" do
      newUser.email = "andre s@cw.com"
      expect(newUser.valid?).to be false
    end

    it "returns false when phone number is empty" do
      newUser.phone_number = nil
      expect(newUser.valid?).to be false
    end

    it "returns false if it's not digits" do
      newUser.phone_number = "asd"
      expect(newUser.valid?).to be false
    end

    it "returns true if it's only digits" do
      expect(newUser.valid?).to be true
    end

    it "returns false if when nickname is empty" do
      newUser.nickname = nil
      expect(newUser.valid?).to be false
    end

    it "returns true if nickname size is >= 2 and <= 10" do
      expect(newUser.valid?).to be true
    end

    it "returns false when age is empty" do
      newUser.age = nil
      expect(newUser.valid?).to be false
    end

    it "returns false if user is underage" do
      newUser.age = 17
      expect(newUser.valid?).to be false
    end

    it "returns false if user age is over 100" do
      newUser.age = 101
      expect(newUser.valid?).to be false
    end
  end
end
