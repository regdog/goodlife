class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :content_nodes do |t|
      t.references :user
      t.string :permalink, :null => false
      t.string :title, :limit => 100, :default => "", :null => false
      t.text   :content, :null => false
      t.datetime :display_on, :null => false
      t.string :type, :limit => 50, :null => false
      t.timestamps
    end

    add_index :content_nodes, ['type', 'id'], :name => "type"
    add_index :content_nodes, :permalink, :unique => true
  end

  def self.down
    drop_table :content_nodes
  end
end
