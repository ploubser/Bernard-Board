# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100818150314) do

  create_table "board_items", :force => true do |t|
    t.string  "name"
    t.integer "height",       :null => false
    t.integer "width",        :null => false
    t.integer "x_axis"
    t.integer "y_axis",       :null => false
    t.string  "board_type"
    t.string  "parameters",   :null => false
    t.integer "refresh_rate"
    t.string  "board"
    t.string  "title"
  end

  create_table "boards", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "width",      :null => false
    t.integer  "height",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "canvas", :force => true do |t|
    t.string   "name"
    t.integer  "height"
    t.integer  "width"
    t.integer  "left"
    t.integer  "top"
    t.string   "itemtype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "griditems", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "type"
    t.string   "co_ordinates"
  end

end
