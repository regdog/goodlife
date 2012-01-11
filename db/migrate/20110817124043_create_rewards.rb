class CreateRewards < ActiveRecord::Migration
  def self.up
    create_table :rewards do |t|
      t.references  :partner
      t.string      :permalink
      t.string      :name, :null => false
      t.text        :information, :null => false
      t.string      :valid_term, :null => false
      t.string      :disclaimer, :null => false
      t.integer     :redeem_points
      t.decimal     :save_money, :precision => 8, :scale => 2
      t.integer     :redeem_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :rewards
  end
end
