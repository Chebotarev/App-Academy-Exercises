class Album < ActiveRecord::Base
  PRODUCTION_TYPES = ["studio", "live"]

  validates :band_id, :name, presence: true
  validates :production, presence: true, inclusion: { in: PRODUCTION_TYPES }

  after_initialize :set_production

  belongs_to :band
  has_many :tracks, dependent: :destroy

  def set_production
    self.production ||= "studio"
  end
end
