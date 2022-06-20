class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, too_short: "%{count} characters minimum" } #, format: { with: /\A[A-Za-z]{2,40}[\D]*[^&%$·"()<>?¿¡!@º*;\^\{\}=\-_]*\z/ }
  validates :surname, presence: true
  validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }, uniqueness: true
  validates :phone_number, presence: true, format: { with: /\A[0-9]{1,20}\z/, message: "Phone number must only contain numbers."}, uniqueness: true
end