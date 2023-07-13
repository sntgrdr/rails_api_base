class AddLongitudLatitudeToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.decimal :latitude, precision: 10, scale: 6, null: false, default: 0.0
      t.decimal :longitude, precision: 10, scale: 6, null: false, default: 0.0
    end
  end
end
