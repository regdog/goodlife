class AddColumnsToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :location
      t.string :phone_number
      t.text :self_description
      t.boolean :prop_notification, :default => false
      t.boolean :checkin_notification, :default => false
      t.boolean :challenge_notification, :default => false
      t.integer :checkin_privacy, :limit => 1, :default => 0
    end
  end

  def self.down
  end
end
