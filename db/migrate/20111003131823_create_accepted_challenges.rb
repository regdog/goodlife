class CreateAcceptedChallenges < ActiveRecord::Migration
  def self.up
    create_table :accepted_challenges do |t|
      t.references :user
      t.references :challenge
      t.datetime :created_at
    end

    add_index :accepted_challenges, :user_id
  end

  def self.down
    drop_table :accepted_challenges
  end
end
