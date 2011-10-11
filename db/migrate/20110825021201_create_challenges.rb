class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.references  :creator, :polymorphic => true
      t.string      :name, :null => false
      t.text        :description, :null => false
      t.integer     :bonus_points
      t.integer     :done_count, :default => 0
      t.datetime    :start_on
      t.datetime    :end_on
      t.timestamps
    end

    add_index :challenges, :name, :unique => true

    create_table :challenges_feats, :id => false do |t|
      t.references  :feat
      t.references  :challenge
    end

    add_index :challenges_feats, [:challenge_id, :feat_id], :unique => true
  end

  def self.down
    drop_table :challenges
    drop_table :challenges_feats
  end
end
