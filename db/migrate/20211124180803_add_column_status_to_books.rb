class AddColumnStatusToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :status, :integer, default: 0
    add_column :books, :booked_at, :datetime
  end
end
