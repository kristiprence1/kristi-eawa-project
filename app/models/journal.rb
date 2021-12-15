class Journal < ApplicationRecord
  has_many :reservations, dependent: :destroy
  enum categories: ['academic', 'historic', 'popular']
  enum status: ["available", "booked"]
end
