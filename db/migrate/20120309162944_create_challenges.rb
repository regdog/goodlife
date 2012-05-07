class CreateChallenges < ActiveRecord::Migration
  def up
    create_table :challenges do |t|
      t.references  :creator, :polymorphic => true
      t.string      :permalink, :null => false
      t.string      :name, :null => false
      t.text        :description, :null => false
      t.integer     :bonus_points, :limit => 3, :default => 0
      t.integer     :participants_count, :default => 0
      t.integer     :period, :limit => 1, :default => 1
      t.datetime    :due_on
      t.boolean     :published, :default => false
      t.string      :image
      t.timestamps
    end

    add_index :challenges, :name, :unique => true
    add_index :challenges, :permalink

    create_table :challenges_feats, :id => false do |t|
      t.references  :feat
      t.references  :challenge
    end

    add_index :challenges_feats, :challenge_id
    add_index :challenges_feats, [:challenge_id, :feat_id], :unique => true
  end

  def down
    drop_table :challenges
    drop_table :challenges_feats
  end
end
