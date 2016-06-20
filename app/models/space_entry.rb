class SpaceEntry < ActiveRecord::Base
  belongs_to :space
  belongs_to :event, inverse_of: :space_entries

  #validates :event_id, presence: true
  validates :space_id, presence: true
  
  validates_datetime :start_time
  validates_datetime :end_time, :after => :start_time

end
