class CreateTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :targets do |t|
      t.references :topic
      t.references :user
      t.string     :title, null: false
      t.decimal    :radius, precision: 8, scale: 2, null: false, default: 0.0
      t.decimal    :latitude, precision: 10, scale: 6, null: false, default: 0.0
      t.decimal    :longitude, precision: 10, scale: 6, null: false, default: 0.0

      t.timestamps
    end
  end
end
