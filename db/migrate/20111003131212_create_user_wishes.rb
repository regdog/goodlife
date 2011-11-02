class CreateUserWishes < ActiveRecord::Migration
  def self.up
    create_table :user_wishes do |t|
      t.references :user
      t.references :reward
    end

    add_index :user_wishes, [:user_id, :reward_id], :unique => true
  end

  def self.down
    drop_table :user_wishes
  end
end
