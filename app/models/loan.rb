class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :reservation
  before_create :set_due_date
  before_validation :set_user, if: -> { user_id.blank? }

  enum status: ['past', 'outstanding', 'overdue', 'closed', "collected"]
  validates_presence_of :amount
  after_update :make_resource_available

  def set_due_date
    self.due_date = Date.current + 2.weeks
  end

  def set_user
    self.user = reservation.user
  end

  def self.calculate_fine
    Loan.each do |loan|

      unless  loan.reservation&.book.nil?
        if loan.reservation&.book.booked_at > DateTime.current
          if loan.fine_amount.nil?
            loan.update(fine_amount: 50, status: "overdue")
          else
            loan.update(fine_amount: (loan.fine_amount + 50), status: "overdue") if loan.fine_amount <= 500
          end
        end
      end

      unless  loan.reservation&.journal.nil?
        if loan.reservation&.journal.booked_at > DateTime.current
          if loan.fine_amount.nil?
            loan.update(fine_amount: 50, status: "overdue")
          else
            loan.update(fine_amount: (loan.fine_amount + 50), status: "overdue") if loan.fine_amount <= 500
          end
        end
      end

    end
  end

  def make_resource_available
    if status == "closed"
      unless reservation.book_id.nil?
        reservation.book.update(status: "available", booked_at: nil)
      end

      unless reservation.journal_id.nil?
        reservation.journal.update(status: "available", booked_at: nil)
      end
    end
  end
end
