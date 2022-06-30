class User < ApplicationRecord
  has_many :vehicles
  has_many :trips

  validates :name, presence: true, length: { minimum: 3, too_short: "%{count} characters minimum" }, format: { with: /\A[^0-9]+\z/ }
  validates :surname, presence: true, format: { with: /\A[^0-9]+\z/ }
  validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }, uniqueness: true
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :nickname, presence: true, length: { minimum: 2, maximum: 10 }, uniqueness: true
  validates :birthday, presence: true
  enum role: { admin: 20, driver: 10, coordinator: 5, passenger: 0, banned: 30 }, _default: 0

  def adult?
    age >= 18
  end

  private

  def age
    currentDate = Time.zone.now
    bornDate = Time.zone.parse(birthday.to_s)
    ((bornDate.to_date...currentDate.to_date).count - 1) / 365.0
  end
end
