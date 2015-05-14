class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
      t.string :user_agent, null: false
    end

    add_index :sessions, :user_id
    add_index :sessions, :session_token, unique: true
  end
end
