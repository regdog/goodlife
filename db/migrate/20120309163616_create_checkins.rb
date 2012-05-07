class CreateCheckins < ActiveRecord::Migration
  def up
    create_table :checkins do |t|
      t.references  :user, :null => false
      t.references  :feat, :null => false
      t.text        :memo
      t.boolean     :epic, :default => false
      t.integer     :privacy
      t.string      :location
      t.datetime    :created_at
    end

    add_index :checkins, :user_id
    add_index :checkins, :feat_id
  end

  def down
    drop_table :checkins
  end
end
