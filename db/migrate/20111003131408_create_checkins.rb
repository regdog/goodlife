class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.references :users, :null => false
      t.references :feat, :null => false
      t.text :memo
      t.integer :public
      t.string :user_ip
      t.datetime :created_at
    end

    add_index :checkins, [:user_id, :feat_id]
  end

  def self.down
    drop_table :checkins
  end
end
