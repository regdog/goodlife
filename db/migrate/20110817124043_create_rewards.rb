class CreateRewards < ActiveRecord::Migration
  def self.up
    create_table :rewards do |t|
      t.string      :name, :null => false
      t.text        :description
      t.integer     :redeem_point
      t.float       :save_money
      t.decimal     :redeem_count, :precision => 8, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :rewards
  end
end
