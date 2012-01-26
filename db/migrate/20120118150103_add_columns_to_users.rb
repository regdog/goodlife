class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :avatar_file_name, :avatar_content_type, :avatar_file_size
      t.string :permalink, :name, :phone, :location, :information
      t.integer :role, :limit => 1, :default => 3
      t.integer :earned_points, :limit => 6, :default => 0
      t.integer :balance_points, :limit => 6, :default => 0
      t.decimal :life_score, :precision => 2, :scale => 1, :default => 0
      t.integer :checkin_privacy, :limit => 1, :default => 0
      t.boolean :prop_notification, :default => false
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :avatar_file_name, :avatar_content_type
      t.remove :avatar_file_size, :permalink
      t.remove :name, :phone, :location, :information
      t.remove :role, :earned_points
      t.remove :balance_points, :life_score
      t.remove :checkin_privacy, :prop_notification
    end
  end
end
