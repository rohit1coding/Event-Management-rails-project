class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :amount
      t.references :task, foreign_key: true
      t.timestamps
    end
  end
end
