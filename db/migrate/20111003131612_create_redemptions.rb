class CreateRedemptions < ActiveRecord::Migration
  def self.up
    create_table :redemptions do |t|
      t.references :user
      t.references :reward
      t.string :name
      t.string :address
      t.string :city
      t.string :region
      t.string :country
      t.string :phone
      t.datetime :created_at
    end

    add_index :redemptions, :user_id
  end

  def self.down
    drop_table :redemptions
  end
end
