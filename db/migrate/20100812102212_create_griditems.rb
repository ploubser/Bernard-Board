class CreateGriditems < ActiveRecord::Migration
  def self.up
    create_table :griditems do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :griditems
  end
end
