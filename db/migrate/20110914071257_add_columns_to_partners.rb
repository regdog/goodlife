class AddColumnsToPartners < ActiveRecord::Migration
  def self.up
    change_table :partners do |t|
      t.string :street
    end
  end

  def self.down
    remove_column :partners, :street
  end
end
