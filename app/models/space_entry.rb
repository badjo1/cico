class SpaceEntry < ActiveRecord::Base
  belongs_to :space
  belongs_to :event, inverse_of: :space_entries
  #validates :event_id, presence: true
  validates :space_id, presence: true
  
  validates_datetime :start_time
  validates_datetime :end_time, :after => :start_time
  validates_date :end_time, :is_at => :start_time , :is_at_message => "End date must be on start date"

  validate :has_not_double_entry

  def duration
    total_seconds = end_time - start_time
    (total_seconds / 60).to_i
  end
  

  private

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
