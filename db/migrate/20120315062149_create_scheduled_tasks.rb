class CreateScheduledTasks < ActiveRecord::Migration
  def up
    create_table :scheduled_tasks do |t|
      t.references  :user
      t.references  :task, :polymorphic => true
      t.integer     :frequency_id
      t.datetime    :due_on
      t.datetime    :completed_at
      t.string      :type
      t.datetime    :created_at
    end

    add_index :scheduled_tasks, :user_id
    add_index :scheduled_tasks, [:task_id, :task_type]
  end

  def down
    drop_table :scheduled_tasks
  end
end
