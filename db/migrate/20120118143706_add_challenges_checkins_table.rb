class AddChallengesCheckinsTable < ActiveRecord::Migration
  def self.up
    create_table :challenges_checkins, :id => false do |t|
      t.references :challenge
      t.references :checkin
    end

    add_index :challenges_checkins, [:challenge_id, :checkin_id], :unique => true
  end

  def self.down
    drop_table :challenges_checkins
  end
end
