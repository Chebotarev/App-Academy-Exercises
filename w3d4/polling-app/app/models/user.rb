class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :responder_id,
    primary_key: :id
  )

  def completed_polls
    sql_query = <<-SQL
      SELECT
        polls.*, COUNT(DISTINCT questions.id) as num_questions
      FROM
        polls
      LEFT OUTER JOIN
        questions ON questions.poll_id = polls.id
      LEFT OUTER JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        responses ON responses.choice_id = answer_choices.id
      WHERE
        responses.responder_id = ?
      GROUP BY
        polls.id
      HAVING
        num_questions != COUNT(responses.id)
    SQL

    Poll.find_by_sql([sql_query, id])
  end

  def completed_polls_active_record
      poll_status.having('num_questions = COUNT(responses.id)')
  end

  def uncompleted_polls_active_record
    poll_status.having('num_questions != COUNT(responses.id)')
  end

  def poll_status
    Poll.all
      .select('polls.*, COUNT(DISTINCT questions.id) as num_questions')
      .joins('LEFT OUTER JOIN questions ON polls.id = questions.poll_id')
      .joins('LEFT OUTER JOIN answer_choices ON answer_choices.question_id = questions.id')
      .joins('LEFT OUTER JOIN responses ON responses.choice_id = answer_choices.id')
      .where('responses.responder_id = ?', id)
      .group('polls.id')
  end
end
