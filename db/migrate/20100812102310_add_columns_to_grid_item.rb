class AddColumnsToGridItem < ActiveRecord::Migration
  def self.up
    add_column :griditems, :name, :string
    add_column :griditems, :type, :string
    add_column :griditems, :co_ordinates, :string
  end

  def self.down
    remove_column :griditems, :co_ordinates
    remove_column :gridotems, :type
    remove_column :griditems, :name
  end
end
