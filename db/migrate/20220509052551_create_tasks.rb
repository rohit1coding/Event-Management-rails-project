class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :completed, :default => false
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
