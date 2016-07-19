class Event < ActiveRecord::Base
  belongs_to :venue_user
  has_many :space_entries, inverse_of: :event, dependent: :destroy
  accepts_nested_attributes_for :space_entries
  composed_of :frequency, mapping: %w(repeat repeat) do |params|
     frequency.new params[:repeat]
  end
  EVENT_TYPES = %w(training workshop appointment unavailable).freeze

  validates :venue_user_id, presence: true
  validates :event_name,  presence: true, length: { maximum: 255 }
  validates :event_type, inclusion: {in: EVENT_TYPES, message: "choose a valid event type."}
  
end
