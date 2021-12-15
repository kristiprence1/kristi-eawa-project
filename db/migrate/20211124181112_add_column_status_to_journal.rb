class AddColumnStatusToJournal < ActiveRecord::Migration[6.1]
  def change
    add_column :journals, :status, :integer, default: 0
    add_column :journals, :booked_at, :datetime
  end
end
