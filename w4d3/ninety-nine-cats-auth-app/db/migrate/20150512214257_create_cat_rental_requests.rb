class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, null: false

      t.timestamps null: false
    end

    add_index :cat_rental_requests, :cat_id
  end
end


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
