describe User, type: :model do
  describe "validation" do
    let(:new_user) {
      User.new(
      name: "Andrew",
      surname: "Cheng",
      email: "andrew@cw.com",
      phone_number: 123131313,
      nickname: "drewan",
      age: 21,
      birthday: "2001-03-20"
    )}

    let(:rep_user) {
      {
        name: "Paco",
        surname: "Li",
        email: "paco@cw.com",
        phone_number: 123123123,
        nickname: "paquito",
        age: 100,
        birthday: "1922-02-14"
      }
    }

    it "returns false when name is empty" do
      new_user.name = nil
      expect(new_user.valid?).to be false
    end

    it "returns false when name has less than 3 chars" do
      new_user.name = "An"
      expect(new_user.valid?).to be false
    end

    it "returns false when name contains numbers" do
      new_user.name = "Andrew20"
      expect(new_user.valid?).to be false
    end

    it "returns false when surname is empty" do
      new_user.surname = nil
      expect(new_user.valid?).to be false
    end

    it "returns true when surname is not empty" do
      expect(new_user.valid?).to be true
    end

    it "returns false when surname contains numbers" do
      new_user.name = "Cheng20"
      expect(new_user.valid?).to be false
    end

    it "returns false when email is empty" do
      new_user.email = nil
      expect(new_user.valid?).to be false
    end

    it "returns true if it's a valid email format" do
      new_user.email = "andres@andres.com"
      expect(new_user.valid?).to be true
    end

    it "returns false if it contains blank spaces" do
      new_user.email = "andre s@cw.com"
      expect(new_user.valid?).to be false
    end

    context "checks email uniqueness" do
      before { User.create!({ **rep_user, email: "andrew@cw.com" }) }
      it { expect(new_user).to be_invalid }
    end

    it "returns false when phone number is empty" do
      new_user.phone_number = nil
      expect(new_user.valid?).to be false
    end

    it "returns false if it's not digits" do
      new_user.phone_number = "asd"
      expect(new_user.valid?).to be false
    end

    it "returns true if it's only digits" do
      expect(new_user.valid?).to be true
    end

    it "returns false if it's only one digit" do
      new_user.phone_number = 2
      expect(new_user.valid?).to be false
    end

    it "returns false eif it's more than 20 digits" do
      new_user.phone_number = 123123123123123123123
      expect(new_user.valid?).to be false
    end

    context "checks phone number uniqueness" do
      before { User.create!({ **rep_user, phone_number: 123131313 }) }
      it { expect(new_user).to be_invalid }
    end

    it "returns false if when nickname is empty" do
      new_user.nickname = nil
      expect(new_user.valid?).to be false
    end

    it "returns true if nickname size is >= 2 and <= 10" do
      expect(new_user.valid?).to be true
    end

    context "checks nickname uniqueness" do
      before { User.create!({ **rep_user, nickname: "drewan" }) }
      it { expect(new_user).to be_invalid }
    end

    it "returns false when age is empty" do
      new_user.age = nil
      expect(new_user.valid?).to be false
    end

    it "returns false if user is underage" do
      new_user.age = 17
      expect(new_user.valid?).to be false
    end

    it "returns false if user age is over 100" do
      new_user.age = 101
      expect(new_user.valid?).to be false
    end

    it "returns true if age is in range" do
      new_user.age = 50
      expect(new_user.valid?).to be true
    end

    it "returns true if user is an adult" do
      currentDate = Time.zone.now
      bornDate = Date.parse(new_user.birthday).to_time
      age = ((currentDate - bornDate) / 1.year.seconds).floor
      expect(age).to be >= 18
    end
  end
end
