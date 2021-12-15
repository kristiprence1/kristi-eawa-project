class LoansController < ApplicationController
  load_and_authorize_resource param_method: :loans_params
  before_action :set_loan, only: [:destroy, :update, :edit, :show]

  def index
    @loans = Loan.all
  end

  def new
    @loan = Loan.new
  end

  def show
    if @loan.update(loans_params)
      redirect_to loans_path, notice: "Loan updated successfully."
    else
      redirect_to loans_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  def create
    loan = Loan.find_by(reservation_id: loans_params[:reservation_id])

    if loan.nil?
      @loan = Loan.new(loans_params)

      if @loan.save
        redirect_to loans_path, notice: "Loan created successfully."
      else
        redirect_to loans_path, alert: "Some thing went wrong, Please try again later."
      end
    else
      redirect_to loans_path, alert: "Loan already exits for this reservation."
    end
  end

  def edit; end

  def update
    if @loan.update(loans_params)
      redirect_to loans_path, notice: "Loan updated successfully."
    else
      redirect_to loans_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  def destroy
    if @loan.destroy
      redirect_to loans_path, notice: "Loan destroyed successfully."
    else
      redirect_to loans_path, alert: "Some thing went wrong, Please try again later."
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loans_params
    params.require(:loan).permit(:user_id, :reservation_id, :amount, :fine_amount, :due_date, :status)
  end
end
