class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.belongs_to :checkin
      t.belongs_to :user
      t.string     :content
      t.string     :user_ip
      t.datetime   :created_at
    end

    add_index :comments, :user_id
    add_index :comments, :checkin_id    
  end

  def down
    drop_table :comments
  end
end
