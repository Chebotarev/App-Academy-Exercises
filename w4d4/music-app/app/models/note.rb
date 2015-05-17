class Note < ActiveRecord::Base
  validates :user_id, :track_id, presence: true
  validates :content, presence: true, blank: false

  belongs_to :user
  belongs_to :track
end
