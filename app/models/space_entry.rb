class SpaceEntry < ActiveRecord::Base
  belongs_to :space
  belongs_to :event, inverse_of: :space_entries

  #validates :event_id, presence: true
  validates :space_id, presence: true
  
  validates_datetime :start_time
  validates_datetime :end_time, :after => :start_time

  validate :has_not_double_entry

  def has_not_double_entry
    double_slot = SpaceEntry.where.not(id: id).where(space_id: space_id)
      .where(" 
        (? >= start_time AND ? < end_time) OR
        (? > start_time AND ? <= end_time) OR
        (? <= start_time AND ? >= end_time)
        ", start_time, start_time, end_time, end_time, start_time, end_time ).exists?
    errors.add(:start_time, "There is an overlap with another slot") if double_slot
  end
end
