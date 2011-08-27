class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.string      :name, :null => false
      t.text        :description, :null => false
      t.integer     :bonus_point
      t.integer     :done_count
      t.datetime    :start_on
      t.datetime    :end_on
      t.timestamps
    end

    create_table :feats_challenges do |t|
      t.references  :feats
      t.references  :challenges
      t.timestamps
    end

    add_index :challenges, :name, :unique => true
  end

  def self.down
    drop_table :challenges
    drop_table :feats_challenges
  end
end
