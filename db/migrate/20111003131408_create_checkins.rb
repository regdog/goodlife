class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.references :user, :null => false
      t.references :feat, :null => false
      t.boolean :epic, :default => false
      t.text :memo
      t.integer :privacy
      t.string :location
      t.datetime :created_at
    end

    add_index :checkins, [:user_id, :feat_id]
  end

  def self.down
    drop_table :checkins
  end
end
