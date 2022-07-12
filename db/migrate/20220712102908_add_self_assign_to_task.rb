class AddSelfAssignToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :self_assign, :boolean, :default => false
  end
end
