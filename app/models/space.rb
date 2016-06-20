class Space < ActiveRecord::Base
  belongs_to :venue
  has_many :space_entries


  validates :venue_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }

end
