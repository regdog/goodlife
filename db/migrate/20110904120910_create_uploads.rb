class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.references :attachable, :polymorphic => true
      t.string  :upload_file_name
      t.string  :upload_content_type
      t.integer :upload_size
      t.string  :type
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
