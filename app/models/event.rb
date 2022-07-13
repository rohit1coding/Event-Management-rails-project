class Event < ApplicationRecord
  belongs_to :user

  has_many :tasks
  has_many :expenses
  
  validates :name, presence: true
end
