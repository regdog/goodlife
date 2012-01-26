class AddCommentsTable < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.belongs_to :checkin
      t.belongs_to :user
      t.string     :content
      t.string     :user_ip
      t.timestamps
    end
  end

  #add_index :comments, [:user_id, :checkin_id]

  def self.down
    drop_table :comments
  end
end
