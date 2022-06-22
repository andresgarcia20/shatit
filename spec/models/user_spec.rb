describe User, type: :model do
  describe "validation" do
    include ActiveSupport::Testing::TimeHelpers

    before { @new_user = create(:user) }

    let(:rep_user) {
      {
        name: "Paco",
        surname: "Li",
        email: "paco@cw.com",
        phone_number: 123123123,
        nickname: "paquito",
        birthday: "1922-02-14"
      }
    }

    it "returns false when name is empty" do
      @new_user.name = nil
      expect(@new_user.valid?).to be false
    end

    it "returns false when name has less than 3 chars" do
      @new_user.name = "An"
      expect(@new_user.valid?).to be false
    end

    it "returns false when name contains numbers" do
      @new_user.name = "Andrew20"
      expect(@new_user.valid?).to be false
    end

    it "returns false when surname is empty" do
      @new_user.surname = nil
      expect(@new_user.valid?).to be false
    end

    it "returns true when surname is not empty" do
      expect(@new_user.valid?).to be true
    end

    it "returns false when surname contains numbers" do
      @new_user.name = "Cheng20"
      expect(@new_user.valid?).to be false
    end

    it "returns false when email is empty" do
      @new_user.email = nil
      expect(@new_user.valid?).to be false
    end

    it "returns true if it's a valid email format" do
      @new_user.email = "andres@andres.com"
      expect(@new_user.valid?).to be true
    end

    it "returns false if it contains blank spaces" do
      @new_user.email = "andre s@cw.com"
      expect(@new_user.valid?).to be false
    end

    it "checks email uniqueness" do
      user2 = build(:user, email: @new_user.email)
      expect(user2).to be_invalid
    end

    it "returns false when phone number is empty" do
      @new_user.phone_number = nil
      expect(@new_user.valid?).to be false
    end

    it "returns false if it's not digits" do
      @new_user.phone_number = "asd"
      expect(@new_user.valid?).to be false
    end

    it "returns true if it's only digits" do
      expect(@new_user.valid?).to be true
    end

    it "returns false if it's only one digit" do
      @new_user.phone_number = 2
      expect(@new_user.valid?).to be false
    end

    it "returns false eif it's more than 20 digits" do
      @new_user.phone_number = 123123123123123123123
      expect(@new_user.valid?).to be false
    end

    it "checks phone number uniqueness" do
      user2 = build(:user, phone_number: @new_user.phone_number)
      expect(user2).to be_invalid
    end

    it "returns false if when nickname is empty" do
      @new_user.nickname = nil
      expect(@new_user.valid?).to be false
    end

    it "returns true if nickname size is >= 2 and <= 10" do
      expect(@new_user.valid?).to be true
    end

    it "checks nickname uniqueness" do
      user2 = build(:user, nickname: @new_user.nickname)
      expect(user2).to be_invalid
    end

    context "verifying if user is adult" do
      before do
        travel_to Time.zone.local(2022, 06, 21)
        @new_user.birthday = Time.zone.parse(born_date).to_date
      end

      context "when the user is born 17 years ago" do
        let(:born_date) {'2004-06-30'}
        it { expect(@new_user.adult?).to be false }
      end

      context "when the user is born 18 years ago" do
        let(:born_date) {'2004-06-21'}
        it "returns true" do
          expect(@new_user.adult?).to be true
        end
      end
    end
  end
end
