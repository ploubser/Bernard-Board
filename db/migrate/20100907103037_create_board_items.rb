class CreateBoardItems < ActiveRecord::Migration
  def self.up
    create_table :board_items do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :board_items
  end
end
