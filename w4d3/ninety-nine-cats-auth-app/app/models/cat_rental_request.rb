class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :user_id, presence: true
  validates :status, inclusion: { in: %w( APPROVED DENIED PENDING ),
     message: "Invalid status!" }
  validate :no_overlapping_approves

  belongs_to :cat
  belongs_to(
    :requester,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  after_initialize :set_status

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_pending_requests.each do |request|
        request.status = "DENIED"
        request.save!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end


  private
  def no_overlapping_approves
    unless overlapping_approved_requests.empty?

      errors[:overlaps] << "date overlap with other approves requests"
    end
  end

  def overlapping_requests
    result = self.cat.cat_rental_requests.select do |request|
      ( [start_date, end_date].any? { |date| date.between?(request.start_date, request.end_date) } ||
      [request.start_date, request.end_date].any? { |date| date.between?(start_date, end_date) } ) &&
      request != self
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select { |request| request.status == "APPROVED" }
  end

  def overlapping_pending_requests
    overlapping_requests.select { |request| request.status == "PENDING" }
  end

  def set_status
    self.status ||= "PENDING"
  end
end

#
# Build out the model
#
# Make a CatRentalRequest model.
# Tracks cat_id, start_date, end_date.
# Also status: starts out "PENDING", but can be switched to "APPROVED" or "DENIED". Use a string for this.
# Add NOT NULL contraints and presence validations. Add an index on cat_id.
# Add an inclusion validation on status.
# Add a validation that no two APPROVED cat requests for the same cat can overlap in time.
# To help, write a method #overlapping_requests, and a second, #overlapping_approved_requests, that builds on top of the first.
# Make sure not to state that a request conflicts with itself.
# You did something similar in the polls app to prevent a user from answering a question twice.
# Add associations between CatRentalRequest and Cat.
# Make sure that when a Cat is deleted, all of its requests should also be deleted. Use :dependent => :destroy.
# One last thing. When you create a new record, the status should be set to an initial value of "PENDING". You can use a after_initialize callback to do this. Use ||= to set status so that we don't overwrite the value when we pull an approved rental request from the DB.
#
