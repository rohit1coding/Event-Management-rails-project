class User < ApplicationRecord
  has_secure_password
  # validates :name, :email, :password, presence: true
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 5, message: "Password must be of minimum 5 letters" }
  
  
end