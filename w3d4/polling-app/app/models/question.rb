class Question < ActiveRecord::Base
  validates :body, :poll_id, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    # results = {}
    # answer_choices_with_responses = answer_choices.includes(:responses)
    #
    # answer_choices_with_responses.each do |answer_choice|
    #   results[answer_choice.body] = answer_choice.responses.length
    # end
    #
    # results

    query_result = answer_choices
      .select('answer_choices.body, COUNT(responses.id) as num_responses')
      .joins('LEFT OUTER JOIN responses ON choice_id = answer_choices.id')
      .group('answer_choices.body')

    result_hash = {}
    query_result.each do |choice|
      result_hash[choice.body] = choice.num_responses
    end

    result_hash
  end
end
