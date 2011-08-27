class ChallengeUser < ActiveRecord::Migration
  def self.up
    create_table :challenges_users, :id => false do |t|
      t.references  :user
      t.references  :challenge
      t.timestamps
    end
  end

  def self.down
    drop_table :challenges_users
  end
end
