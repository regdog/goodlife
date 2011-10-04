class CreateChallengesTodos < ActiveRecord::Migration
  def self.up
    create_table :challenge_todos do |t|
      t.references :user
      t.references :challenge
      t.references :feat
      t.datetime :start_on
      t.datetime :end_on
      t.datetime :created_at
    end

    add_index :challenge_todos, [:user_id, :challenge_id]
    add_column :checkins, :challenge_id, :integer
    add_column :accepted_challenges, :completed_on, :datetime
    rename_column :accepted_challenges, :created_at, :accepted_on
  end

  def self.down
    drop_table :challenge_todos
  end
end
