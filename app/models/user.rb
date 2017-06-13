class User < ActiveRecord::Base
  has_many :venue_users, -> { includes :venue }
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email

  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password(validations: false) #https://github.com/rails/rails/blob/ef5d85709d346e55827e88f53430a2cbe1e5fb9e/activemodel/lib/active_model/secure_password.rb#L51
  with_options if: :needs_password_validation? do |active_user|
     active_user.validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
     active_user.validates_confirmation_of :password
  end

  def needs_password_validation?
    activated? || activation_digest.present?
  end
  
  def fullname
    [first_name.capitalize, prefix, last_name.capitalize].reject(&:blank?).join(' ')
  end

  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

   # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

    # Returns true if the given token matches the digest.
  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    update_attribute(:activation_token, User.new_token)
    update_attribute(:activation_digest, User.digest(activation_token))
    UserMailer.account_activation(self).deliver_now
  end


  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

    # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Creates and assigns the activation token and digest.
  #def create_activation_digest
    #self.activation_token  = User.new_token
    #self.activation_digest = User.digest(activation_token)
  #end


  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end


end
