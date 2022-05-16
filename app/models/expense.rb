class Expense < ApplicationRecord
  belongs_to :task
  validates :name, :amount, presence: true
end
