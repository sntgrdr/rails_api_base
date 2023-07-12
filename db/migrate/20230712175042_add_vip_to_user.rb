class AddVipToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.boolean :vip, default: false
    end
  end
end
