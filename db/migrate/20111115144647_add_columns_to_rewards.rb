class AddColumnsToRewards < ActiveRecord::Migration
  def self.up
    change_table :rewards do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.string :uuid, :limit => 36, :null => true
      t.string :phone
    end
  end

  def self.down
  end
end
