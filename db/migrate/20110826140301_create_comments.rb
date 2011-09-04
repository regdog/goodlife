class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.belongs_to :checkins
      t.belongs_to :user
      t.text       :content
      t.string     :user_ip
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
