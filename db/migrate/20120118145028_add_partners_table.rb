class AddPartnersTable < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.references :tag
      t.string :business_name, :null => false
      t.string :industry
      t.text :information
      t.string :website
      t.string :contact
      t.string :title
      t.string :phone
      t.string :email
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :partners
  end
end
