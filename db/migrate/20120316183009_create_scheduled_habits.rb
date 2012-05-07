class CreateScheduledHabits < ActiveRecord::Migration
  def up
    create_table :scheduled_habits do |t|
      t.references  :user
      t.references  :feat
      t.integer     :frequency_id
      t.datetime    :created_at
    end

    add_index :scheduled_habits, :user_id
    add_index :scheduled_habits, :feat_id
  end

  def down
    drop_table :scheduled_habits
  end
end
