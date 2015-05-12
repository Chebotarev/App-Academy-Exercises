class Response < ActiveRecord::Base
  validates :responder_id, :choice_id, presence: true
  validate :respondent_has_not_already_answered_question,
          :respondent_is_not_poll_author

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :responder_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses

    Response.joins(:question).where('responses.id != ?', id)
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.where('responder_id = ?', responder_id).exists?
      errors.add(:respondent, 'already answered this question')
    end
  end

  def respondent_is_not_poll_author
    if Poll.joins(:answer_choices).where(author_id: responder_id).exists?
      errors.add(:respondent, 'is the author of the poll')
    end
  end
end
