class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, too_short: "%{count} characters minimum" } #, format: { with: /\A[A-Za-z]{2,40}[\D]*[^&%$·"()<>?¿¡!@º*;\^\{\}=\-_]*\z/ }
  validates :surname, presence: true
end
