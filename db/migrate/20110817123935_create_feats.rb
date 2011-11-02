class CreateFeats < ActiveRecord::Migration
  def self.up
    create_table :feats do |t|
      t.references    :creator, :polymorphic => true
      t.string        :name, :limit => 100, :null => false
      t.text          :why
      t.text          :how
      t.integer       :bonus_points, :limit => 3, :default => 0
      t.integer       :checkin_count, :default => 0
      t.boolean       :published, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :feats
  end
end
