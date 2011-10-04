class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.references :category
      t.string :name, :null => false
      t.text :description
      t.string :website
      t.string :country
      t.string :region
      t.string :city
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :partners
  end
end