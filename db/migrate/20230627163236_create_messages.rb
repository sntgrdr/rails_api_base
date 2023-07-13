class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :conversation
      t.references :user
      t.string :content, null: false

      t.timestamps
    end
  end
end
