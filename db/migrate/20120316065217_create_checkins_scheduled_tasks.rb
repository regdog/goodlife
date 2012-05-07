class CreateCheckinsScheduledTasks < ActiveRecord::Migration
  def up
    create_table :checkins_scheduled_tasks, :id=> false do |t|
      t.references :checkin
      t.references :scheduled_task
    end

    add_index :checkins_scheduled_tasks, :checkin_id
    add_index :checkins_scheduled_tasks, :scheduled_task_id
  end

  def down
    drop_table :checkins_scheduled_tasks
  end
end
