class Book < ApplicationRecord
  has_many :reservations, dependent: :destroy
  attr_accessor :volume
  enum categories: ['Romance', 'Historical', 'Biographical', 'Bildungroman', 'Science']
  enum status: ["available", "booked"]
end
