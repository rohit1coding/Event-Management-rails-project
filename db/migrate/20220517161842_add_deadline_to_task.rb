class AddDeadlineToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :deadline, :datetime
  end
end
