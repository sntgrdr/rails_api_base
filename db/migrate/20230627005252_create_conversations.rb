class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.integer :user_from
      t.integer :user_to

      t.timestamps
    end

    add_foreign_key :conversations, :users, column: :user_from
    add_foreign_key :conversations, :users, column: :user_to

    add_index :conversations, :user_from
    add_index :conversations, :user_to
  end
end
