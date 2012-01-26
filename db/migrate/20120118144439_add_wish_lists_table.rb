class AddWishListsTable < ActiveRecord::Migration
  def self.up
    create_table :wish_lists do |t|
      t.references :user
      t.references :reward
    end

    add_index :wish_lists, [:user_id, :reward_id], :unique => true
  end

  def self.down
    drop_table :wish_lists
  end
end
