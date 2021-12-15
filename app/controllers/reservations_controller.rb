class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all
  end

  def create
    reservation = Reservation.new(reservations_params)
    if reservation.save
      redirect_to root_path, notice: "Reserved Successfully."
    else
      redirect_to root_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  def show
    reservation = Reservation.find(params[:id])

    if reservation.update(reservations_params)
      redirect_to reservations_path, notice: "Reservation updated Successfully."
    else
      redirect_to reservations_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  private

  def reservations_params
    params.require(:reservation).permit(:book_id, :user_id, :reservation_date, :status, :journal_id)
  end
end
