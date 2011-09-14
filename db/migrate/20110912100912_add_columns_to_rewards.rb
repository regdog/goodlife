class AddColumnsToRewards < ActiveRecord::Migration
  def self.up
    change_table :rewards do |t|
      t.references :partner
    end
  end

  def self.down
    remove_column :rewards, :partner_id
  end
end
