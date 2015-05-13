class CatRentalRequest < ActiveRecord::Base
  belongs_to :cat

  validates :cat_id, :start_date, :end_date, presence: true
  validates(
    :status, presence: true, inclusion: {in: %w[PENDING APPROVED DENIED]}
  )
  #validate :cat_chosen
  validate :no_overlapping_approved_requests

  after_initialize :set_status

  def cat_chosen
    if cat_id == 0
      errors.add(:cat_chosen, "Must choose cat")
    end
  end

  def overlapping_requests
    CatRentalRequest
    .where("cat_id = ? AND id != ? ", cat_id, id)
    .where(
      "(start_date BETWEEN :start_date AND :end_date) OR
      (end_date BETWEEN :start_date AND :end_date)",
      {start_date: start_date, end_date: end_date}
    )
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED' ")
  end

  def no_overlapping_approved_requests
    unless overlapping_approved_requests.empty? || self.status == "DENIED"
      errors.add(:overlap, "Cat already rented out during part of that period")
    end
  end

# protected
  def set_status
    self.status ||= "PENDING"
  end

  def approve!
    self.update!(status: "APPROVED")
    conflicts = overlapping_requests
    conflicts.each do |conflict|
      conflict.deny!
    end
  end

  def deny!
    self.update!(status: "DENIED")
  end

end
