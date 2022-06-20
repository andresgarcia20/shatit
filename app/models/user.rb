class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, too_short: "%{count} characters minimum" } #, format: { with: /\A[A-Za-z]{2,40}[\D]*[^&%$·"()<>?¿¡!@º*;\^\{\}=\-_]*\z/ }
  validates :surname, presence: true
  validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }, uniqueness: true
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :nickname, presence: true, length: { minimum: 2,  maximum: 10 }, uniqueness: true
  validates :age, presence: true, :inclusion => 18..100
end