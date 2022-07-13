class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :amount
      t.integer :task_id
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
