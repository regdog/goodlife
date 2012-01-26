class AddContentsTable < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.references :tag
      t.string :permalink, :null => false
      t.string :title, :limit => 100, :default => "", :null => false
      t.text   :content, :null => false
      t.boolean :draft, :default => true
      t.timestamps
    end

    add_index :contents, :permalink, :unique => true
  end

  def self.down
    drop_table :contents
  end
end
