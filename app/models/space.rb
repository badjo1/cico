class Space < ActiveRecord::Base
  belongs_to :venue

  validates :venue_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }

end
