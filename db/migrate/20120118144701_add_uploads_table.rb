class AddUploadsTable < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.references :attachable, :polymorphic => true
      t.string  :upload_file_name
      t.string  :upload_content_type
      t.integer :upload_file_size
      t.datetime :upload_updated_at
      t.string  :type
    end

    add_index :uploads, [:attachable_id, :attachable_type]
    add_index :uploads, :upload_file_name
  end

  def self.down
    drop_table :uploads
  end
end
