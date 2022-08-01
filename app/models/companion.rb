class Companion < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, too_short: "%{count} characters minimum" }, format: { with: /\A[^0-9]+\z/ }
  validates :surname, presence: true, format: { with: /\A[^0-9]+\z/ }
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { minimum: 2, maximum: 20 }, uniqueness: true
end
