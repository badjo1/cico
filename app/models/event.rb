class Event < ActiveRecord::Base
  belongs_to :venue_user
  has_many :space_entries, inverse_of: :event, dependent: :destroy

  accepts_nested_attributes_for :space_entries

  validates :venue_user_id, presence: true
  validates :event_name,  presence: true, length: { maximum: 255 }
end
