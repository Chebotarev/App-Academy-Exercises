class RemoveResponseUniqueConstraint < ActiveRecord::Migration
  def up
    remove_index(:responses, :responder_id)
    remove_index(:responses, :choice_id)

    add_index(:responses, :responder_id)
    add_index(:responses, :choice_id)
  end

  def down
    remove_index(:responses, :responder_id)
    remove_index(:responses, :choice_id)

    add_index(:responses, :responder_id, unique: true)
    add_index(:responses, :choice_id, unique: true)
  end
end
