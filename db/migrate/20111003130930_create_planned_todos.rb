class CreatePlannedTodos < ActiveRecord::Migration
  def self.up
    create_table :planned_todos do |t|
      t.references :user
      t.references :feat
      t.string :frequency
      t.datetime :created_at
    end

    add_index :planned_todos, [:user_id, :feat_id], :unique => true
  end

  def self.down
    drop_table :planned_todos
  end
end
