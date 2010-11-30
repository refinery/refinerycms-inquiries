class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table ::Inquiry.table_name, :force => true do |t|
      t.string   "name"
      t.string   "email"
      t.string   "phone"
      t.text     "message"
      t.integer  "position"
      t.boolean  "open",       :default => true
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "spam",       :default => false
    end

    # todo: remove at 1.0
    create_table ::InquirySetting.table_name, :force => true do |t|
      t.string   "name"
      t.text     "value"
      t.boolean  "destroyable"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index ::Inquiry.table_name, :id
  end

  def self.down
     remove_table ::Inquiry.table_name
     # todo: remove at 1.0
     remove_table ::InquirySetting.table_name
  end
end