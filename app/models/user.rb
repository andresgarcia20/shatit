class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 } #, format: { with: /\A[\w'\-,.][^0-9_!¡?÷?¿\/\\+=@#$%\ˆ&*()\{\}|~<>;:[\]]{3,}\z/i }
end
