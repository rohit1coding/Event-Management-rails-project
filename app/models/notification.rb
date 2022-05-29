class Notification < ApplicationRecord
  belongs_to :user
  validates :message, :user_id, :task_id, :event_id, :admin_id, presence: true

end
