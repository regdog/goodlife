class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.references :user
      t.references :feat
      t.integer :public
      t.string :user_ip
      t.datetime :created_at
    end

    add_index :checkins, :user_id
  end

  def self.down
    drop_table :checkins
  end
end
