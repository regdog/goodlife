class AddColumnsToPartners < ActiveRecord::Migration
  def self.up
    change_table :partners do |t|
      t.string :permalink
      t.rename :name, :business_name
      t.rename :region, :state
      t.rename :zip_code, :zipcode
      t.string :contact
      t.string :title
      t.string :phone
      t.string :email
    end
  end

  def self.down
  end
end
