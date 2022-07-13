class Expense < ApplicationRecord
  belongs_to :event
  
  validates :name, :amount, presence: true
end
