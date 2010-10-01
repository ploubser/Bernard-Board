class CreateCanvas < ActiveRecord::Migration
  def self.up
    create_table :canvas do |t|
      t.string :name
      t.integer :height
      t.integer :width
      t.integer :left
      t.integer :top
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :canvas
  end
end
