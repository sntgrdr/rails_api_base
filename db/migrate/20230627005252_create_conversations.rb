class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :target, foreign_key: true
      t.bigint :user_from
      t.bigint :user_to

      t.timestamps
    end

    add_foreign_key :conversations, :users, column: :user_from
    add_foreign_key :conversations, :users, column: :user_to

    add_index :conversations, :user_from
    add_index :conversations, :user_to
  end
end
