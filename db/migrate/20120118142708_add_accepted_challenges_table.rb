class AddAcceptedChallengesTable < ActiveRecord::Migration
  def self.up
    create_table :accepted_challenges do |t|
      t.references :user
      t.references :challenge
      t.datetime :accepted_on
      t.datetime :complete_on
    end

    add_index :accepted_challenges, [:user_id, :challenge_id]
  end

  def self.down
    drop_table :accepted_challenges
  end
end
