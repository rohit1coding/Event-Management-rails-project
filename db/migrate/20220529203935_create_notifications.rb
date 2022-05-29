class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.text :message
      t.integer :event_id
      t.integer :task_id
      t.integer :admin_id
      t.boolean :is_read, :default => false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
