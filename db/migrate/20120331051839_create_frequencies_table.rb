class CreateFrequenciesTable < ActiveRecord::Migration
  def up
    create_table :frequencies do |t|
      t.integer     :value
    end
  end

  def down
    drop_table :frequencies
  end
end
