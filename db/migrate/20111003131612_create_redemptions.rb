class CreateRedemptions < ActiveRecord::Migration
  def self.up
    create_table :redemptions do |t|
      t.references :user
      t.references :reward
      t.datetime :created_at
    end

    add_index :redemptions, :user_id
  end

  def self.down
    drop_table :redemptions
  end
end
