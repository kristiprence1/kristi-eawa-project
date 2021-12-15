class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, index: true
      t.references :book, index: true
      t.references :journal, index: true
      t.date :reservation_date
      t.integer :status

      t.timestamps
    end
  end
end
