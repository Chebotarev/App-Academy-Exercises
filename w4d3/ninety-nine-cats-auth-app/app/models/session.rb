class Session < ActiveRecord::Base
  validates :user_id, :session_token, :user_agent, presence: true
  validates :session_token, uniqueness: true

  after_initialize :ensure_session_token

  belongs_to :user

  def self.create_session_token
    SecureRandom.urlsafe_base64
  end
  def ensure_session_token
    self.session_token ||= Session.create_session_token
  end

  def reset_session_token!
    self.session_token = User.create_session_token
    save!
    self.session_token
  end
end
