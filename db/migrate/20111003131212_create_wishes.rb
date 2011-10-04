class CreateWishes < ActiveRecord::Migration
  def self.up
    create_table :wishes do |t|
      t.references :user
      t.references :reward
      t.datetime :created_at
    end

    add_index :wishes, :user_id
  end

  def self.down
    drop_table
  end
end
