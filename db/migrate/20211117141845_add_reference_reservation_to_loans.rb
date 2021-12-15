class AddReferenceReservationToLoans < ActiveRecord::Migration[6.1]
  def change
    add_reference :loans, :reservation, index: true
  end
end
