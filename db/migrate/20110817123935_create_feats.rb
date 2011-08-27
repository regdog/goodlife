class CreateFeats < ActiveRecord::Migration
  def self.up
    create_table :feats do |t|
      t.string        :title, :limit => 20, :null => false
      t.string        :description, :limit => 60, :null => false
      t.text          :why
      t.text          :how
      t.integer       :bonus_point
      t.integer       :done_count
      t.date          :date_available
      t.timestamps
    end
  end

  def self.down
    drop_table :feats
  end
end
