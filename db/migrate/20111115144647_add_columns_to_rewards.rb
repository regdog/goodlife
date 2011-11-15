class AddColumnsToRewards < ActiveRecord::Migration
  def self.up
    change_table :rewards do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.string :zipcode
    end
  end

  def self.down
  end
end
