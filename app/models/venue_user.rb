class VenueUser < ActiveRecord::Base
  ADMIN_ROLE_NAME = 'admin'
  belongs_to :user
  belongs_to :venue
  
  validates :user_id, presence: true
  validates :venue_id, presence: true

  def self.find_most_recent_by(userid)
    venueuser = VenueUser.where("user_id = ?", userid).order(activated_at: :desc).first
  end

  def admin?
    role == ADMIN_ROLE_NAME
  end
  # def activate
  #   self.update_columns(activeated_at: Time.current)
  # end

end
