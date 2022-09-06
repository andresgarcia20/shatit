class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :vehicles
  has_many :trips
  has_many :trip_join_requests
  has_many :companions
  has_one :driver_requests

  validates :name, presence: true, length: { minimum: 3, too_short: "%{count} characters minimum" }, format: { with: /\A[^0-9]+\z/ }
  validates :surname, presence: true, format: { with: /\A[^0-9]+\z/ }
  validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }, uniqueness: true
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :nickname, presence: true, length: { minimum: 2, maximum: 10 }, uniqueness: true
  validates :birthday, presence: true

  enum role: { admin: 20, driver: 10, coordinator: 5, passenger: 0, banned: 30 }, _default: 0

  scope :by_email, ->(email) { where("email = ?", email) }
  scope :by_age, ->(age) { where("DATE_PART('year', AGE(birthday)) = ?", age) }
  scope :by_status, ->(status) { where("role = ?", status) }

  def fullname
    "#{name} #{surname}".strip
  end

  def adult?
    age >= 18
  end

  def age
    currentDate = Time.zone.now
    bornDate = Time.zone.parse(birthday.to_s)
    ((bornDate.to_date...currentDate.to_date).count - 1) / 365.0
  end

  def jwt_payload
    {
      "context": {
        "id": id,
        "name": name,
        "role": role,
      },
    }
  end
end
