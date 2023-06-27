class CreateConversationUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_users do |t|
      t.references :conversation
      t.references :user

      t.timestamps
    end
  end
end
