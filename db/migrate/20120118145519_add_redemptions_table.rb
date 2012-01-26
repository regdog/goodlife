class AddRedemptionsTable < ActiveRecord::Migration
  def self.up
    create_table :redemptions do |t|
      t.references :user
      t.references :reward
      t.string :token
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :phone
      t.datetime :created_at
    end

    add_index :redemptions, :user_id
  end

  def self.down
    drop_table :redemptions
  end
end
