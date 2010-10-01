class RenameTypeInCanvas < ActiveRecord::Migration
  def self.up
      rename_column :canvas, :type, :itemtype
  end

  def self.down
  end
end
