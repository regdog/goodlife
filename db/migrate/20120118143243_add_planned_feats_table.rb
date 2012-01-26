class AddPlannedFeatsTable < ActiveRecord::Migration
  def self.up
    create_table :planned_feats do |t|
      t.references :user
      t.references :feat
      t.string :period
      t.timestamps
    end

    add_index :planned_feats, [:user_id, :feat_id], :unique => true
  end

  def self.down
    drop_table :planned_feats
  end
end
