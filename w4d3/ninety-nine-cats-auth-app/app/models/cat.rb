# require 'action_view'    What does that mean?

class Cat < ActiveRecord::Base
  CAT_COLORS = ["Blue", "Red", "Green", "Orange", "Yellow", "Brown", "Black"]
  validates :birth_date, :color, :name, :sex, :description, presence: true

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)
  validates :user_id, presence: true

  # The above is a cleaner way of doing the custom validations below.
  #
  # validate :valid_color
  # validate :valid_age
  # validate :valid_sex

  belongs_to(
  :owner,
  class_name: 'User',
  foreign_key: :user_id,
  primary_key: :id
  )
  has_many :cat_rental_requests, dependent: :destroy





  def age
    (Time.now - birth_date)
  end

  # def find_with_owner_and_requests
  #   self.
  #   # @cat = Cat.find(params[:id]).includes(:owner, :cat_rental_requests)
  # end

  private

  def valid_color
    # return nil if self.color.nil?
    if !COLORS.include?(self.color)
      errors[:color] << "Invalid Cat Color" # Remember what validate looks for!
    end
  end

  def valid_age
    # return nil if self.birth_date.nil?
    if birth_date > Time.now
      errors[:age] << "Invalid birth date"
    end
  end

  def valid_sex
    # return nil if self.sex.nil?
    if !["M", "F"].include?(self.sex)
      errors[:sex] << "Invalid Cat gender"
    end
  end

end

# Build a Cat model. Attributes should include:
#
# birth_date
# Add an age method using birth_date
# color
# Require the user to choose from a standard set of colors.
# Add an inclusion validation for this.
# name
# sex
# Represent as a one-character string.
# Add an inclusion validation so that sex is "M" or "F".
# description
# Use a TEXT column to store arbitrarily long text describing fond memories the user has of their time with the Cat.
# Add any necessary presence validations.
