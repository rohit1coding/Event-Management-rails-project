class CreateAssignedTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :assigned_tasks do |t|
      t.integer :task_id
      t.references :user, foreign_key: true
      t.integer :admin_id

      t.timestamps
    end
  end
end
