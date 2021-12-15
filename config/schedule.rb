every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  runner "Reservation.cancel_reservation"
end

every 1.day, at: '6:00 pm'  do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  runner "Loan.calculate_fine"
end