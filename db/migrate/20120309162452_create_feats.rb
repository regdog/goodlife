class CreateFeats < ActiveRecord::Migration
  def up
    create_table :feats do |t|
      t.string        :permalink
      t.string        :name, :limit => 100, :null => false
      t.text          :why
      t.text          :how
      t.integer       :bonus_points, :limit => 2, :default => 0
      t.integer       :checkin_count, :default => 0
      t.boolean       :published, :default => false
      t.string        :image
      t.timestamps
    end

    add_index :feats, :permalink
    add_index :feats, :name
  end

  def down
    drop_table :feats
  end
end
