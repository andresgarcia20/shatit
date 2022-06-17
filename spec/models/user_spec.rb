describe User, type: :model do
  describe 'validation' do
    it 'returns false when name is empty' do
      expect(User.new(name: nil).valid?).to be false
    end
  end
end