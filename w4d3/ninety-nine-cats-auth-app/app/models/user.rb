class User < ActiveRecord::Base
  attr_accessor :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats
  has_many :cat_rental_requests

  after_initialize :ensure_session_token

  def self.find_by_credentials(user_name, password)
    user = User.find_by(username: user_name)

    if user && user.is_password?(password)
      return user
    end

    nil
  end

  def self.create_session_token
    SecureRandom.urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def ensure_session_token
    self.session_token ||= User.create_session_token
  end

  def reset_session_token!
    self.session_token = User.create_session_token
    save!
    self.session_token
  end
end
