class CreateConversationTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_targets do |t|
      t.references :conversation
      t.references :target

      t.timestamps
    end
  end
end
