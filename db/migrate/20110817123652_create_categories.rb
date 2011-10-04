class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :category_type
      t.integer :parent_id
      t.integer :position
    end

    add_index :categories, [:name, :category_type], :unique => true
  end

  def self.down
    drop_table :categories
  end
end
