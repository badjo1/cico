class Venue < ActiveRecord::Base
  has_many :venue_users
  has_many :spaces
  has_many :space_entries, through: :spaces

  validates :name,  presence: true, length: { maximum: 50 }


end


