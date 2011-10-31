class CreatePlannedTodos < ActiveRecord::Migration
  def self.up
    create_table :planned_todos do |t|
      t.references :users
      t.references :feat
      t.string :plan_type
      t.datetime :created_at
    end

    add_index :planned_todos, [:user_id, :feat_id], :unique => true
  end

  def self.down
    drop_table :planned_todos
  end
end
