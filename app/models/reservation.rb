class Reservation < ApplicationRecord
  belongs_to :user
  has_one :loan, dependent: :destroy
  belongs_to :book, optional: true
  belongs_to :journal, optional: true

  enum status: ['pending', 'approved', "rejected"]

  validates_presence_of :reservation_date

  after_create :set_date
  after_update :create_loan
  after_update :make_unreserved

  def set_date
    unless book_id.nil?
      book.update(status: "booked", booked_at: DateTime.current)
    end

    unless journal_id.nil?
      journal.update(status: "booked", booked_at: DateTime.current)
    end
  end

  def self.cancel_reservation
    Reservation.where(status: "pending").all.each do |reservation|
      if (reservation.created_at + 2.hours).to_s(:time) > DateTime.current.to_s(:time)
        unless reservation.book_id.nil?
          reservation.book.update(status: "booked", booked_at: DateTime.current)
        end

        unless reservation.journal_id.nil?
          reservation.journal.update(status: "booked", booked_at: DateTime.current)
        end
      end
    end
  end

  def create_loan
    if status == "approved"
      loan = Loan.new(user_id: user_id, reservation_id: id, amount: 20, due_date: (Date.current + 2.weeks), status: "outstanding")
      loan.save
    end
  end

  def make_unreserved
    if status == "rejected"
      unless book_id.nil?
        book.update(status: "available", booked_at: nil)
      end

      unless journal_id.nil?
        journal.update(status: "available", booked_at: nil)
      end
    end
  end
end
