class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.references :user
      t.references :feat
      t.integer :frequency
      t.datetime :created_at
    end

    add_index :todos, :user_id
  end

  def self.down
    drop_table :todos
  end
end
