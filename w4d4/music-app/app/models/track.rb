class Track < ActiveRecord::Base
  VARIETIES = ["regular", "bonus"]

  validates :album_id, :name, presence: true
  validates :variety, presence: true, inclusion: { in: VARIETIES }

  after_initialize :set_variety

  belongs_to :album

  has_many :notes
  
  has_one(
    :band,
    through: :album,
    source: :band
  )

  def set_variety
    self.variety ||= "regular"
  end
end
