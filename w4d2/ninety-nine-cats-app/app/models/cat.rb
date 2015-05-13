class Cat < ActiveRecord::Base
  CAT_COLORS = ["white", "orange", "black", "calico"]

  has_many :cat_rental_requests, dependent: :destroy

  validates :birth_date, :name, :description, presence: true
  validates :sex, inclusion: { in: ["m", "f"] }, presence: true
  validates(
    :color,
    inclusion: { in: CAT_COLORS },
    presence: true
  )

  def self.colors
    CAT_COLORS
  end

  def age
    Time.now.year - birth_date.year
  end

end
