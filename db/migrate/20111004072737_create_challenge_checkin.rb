class CreateChallengeCheckin < ActiveRecord::Migration
  def self.up
    create_table :challenge_checkin, :id => false do |t|
      t.references :challenge
      t.references :checkin
    end

    add_index :challenge_checkin, [:challenge_id, :checkin_id], :unique => true
  end

  def self.down
    drop_table :challenge_checkin
  end
end
