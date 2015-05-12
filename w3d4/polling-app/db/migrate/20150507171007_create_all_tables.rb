class CreateAllTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
    end

    add_index(:users, :user_name, unique: true)

    create_table :polls do |t|
      t.string :title
      t.integer :author_id
    end

    add_index(:polls, :author_id, unique: true)

    create_table :questions do |t|
      t.text :body
      t.integer :poll_id
    end

    add_index(:questions, :poll_id)

    create_table :answer_choices do |t|
      t.text :body
      t.integer :question_id
    end

    add_index(:answer_choices, :question_id)

    create_table :responses do |t|
      t.integer :responder_id
      t.integer :choice_id
    end

    add_index(:responses, :responder_id, unique: true)
    add_index(:responses, :choice_id, unique: true)
  end
end
