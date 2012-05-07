class CreateScheduledChallenges < ActiveRecord::Migration
  def up
    create_table :scheduled_challenges do |t|
      t.references  :user
      t.references  :challenge
      t.datetime    :due_on
      t.datetime    :completed_at
      t.datetime    :created_at
    end

    add_index :scheduled_challenges, :user_id
    add_index :scheduled_challenges, :challenge_id
  end

  def down
    drop_table :scheduled_challenges
  end
end
