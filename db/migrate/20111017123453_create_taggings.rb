class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.string :kind
      t.integer :position
    end

    add_index :tags, [:name, :kind], :unique => true

    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, :polymorphic => true
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type], :unique => true
  end

  def self.down
    drop_table :tags
    drop_table :taggings
  end
end
