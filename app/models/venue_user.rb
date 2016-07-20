class VenueUser < ActiveRecord::Base
  ADMIN_ROLE_NAME = 'admin'
  belongs_to :user
  belongs_to :venue
  has_many :events, -> { order(created_at: :desc) }
  has_many :space_entries, through: :events  
  
  validates :user_id, presence: true
  validates :venue_id, presence: true
  validates_uniqueness_of :user_id, :scope => :venue_id

  #make user initials, fullname accessible directly
  delegate :fullname, :initials, to: :user, prefix: false 


  def self.find_most_recent_by(userid)
    venueuser = VenueUser.where("user_id = ?", userid).order(visit_on: :desc).first
  end

  def planned_events
    space_entries.where("space_entries.start_time >= ?", Time.zone.now.beginning_of_day)
    .includes(:event).order('space_entries.start_time ASC')
  end

  def archived_events
    space_entries
    .where("space_entries.start_time < ?", Time.zone.now.beginning_of_day)
    .includes(:event).order('space_entries.start_time DESC')
  end

  # def archived_events
  #   events.joins(:space_entries)
  #   .where("space_entries.start_time < ?", Time.zone.now.beginning_of_day)
  #   .includes(:space_entries).order('space_entries.start_time DESC')
  # end

  def appointments
    archived_events.where(event_type: :appointment)
  end

  def workshops
    archived_events.where(event_type: :workshop)
  end

  def training
    archived_events.where(event_type: :training)
  end

  def admin?
    role == ADMIN_ROLE_NAME
  end
  # def activate
  #   self.update_columns(activeated_at: Time.current)
  # end

   # set current.
  def set_current
    update_attribute(:visit_on, Time.zone.now)
  end

end
