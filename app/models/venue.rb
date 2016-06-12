class Venue < ActiveRecord::Base
  has_many :venue_users

  before_save   :downcase_subdomain

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_SUBDOMAIN_REGEX =  /\A[a-zA-Z0-9\-]+\z/
  validates :subdomain, presence: true, length: { maximum: 50 },
                    format: { with: VALID_SUBDOMAIN_REGEX },
                    exclusion: { in: %w(www)},
                    uniqueness: { case_sensitive: false }
  private

    # Converts email to all lower-case.
    def downcase_subdomain
      self.subdomain = subdomain.downcase
    end

end


