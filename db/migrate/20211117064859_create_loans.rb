class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.references :user, index: true
      t.float :amount
      t.float :fine_amount
      t.date :due_date
      t.integer :status

      t.timestamps
    end
  end
end
