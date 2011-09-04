class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.string  :filename
      t.integer :width, :null => false, :default => 0
      t.integer :height, :null => false, :default => 0
      t.string  :type
      t.integer :parent_id
      t.string  :content_type
      t.string  :thumbnail
      t.integer :size
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
