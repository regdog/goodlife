class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares, :force => true do |t|
      t.references :user
      t.string :shareable_type, :limit => 30
      t.integer :shareable_id
      t.string :shared_to_type, :limit => 30
      t.integer :shared_to_id
      t.boolean :restricted, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :shares
  end
end
