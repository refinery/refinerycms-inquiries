class CreateInquiries < ActiveRecord::Migration
  def up
    unless ::Refinery::Inquiry.table_exists?
      create_table ::Refinery::Inquiry.table_name, :force => true do |t|
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

      add_index ::Refinery::Inquiry.table_name, :id
    end
  end

  def down
     drop_table ::Refinery::Inquiry.table_name

     ::Refinery::Page.delete_all({
       :link_url => ("/contact" || "/contact/thank_you")
     }) if defined?(::Refinery::Page)
  end
end
