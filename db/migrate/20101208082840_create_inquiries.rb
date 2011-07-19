class CreateInquiries < ActiveRecord::Migration
  def self.up
    unless ::Inquiry.table_exists?
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

      add_index ::Inquiry.table_name, :id
    end

    ::Page.reset_column_information if defined?(::Page)

    load(Rails.root.join('db', 'seeds', 'pages_for_inquiries.rb').to_s)
  end

  def self.down
     drop_table ::Inquiry.table_name

     ::Page.delete_all({
       :link_url => ("/contact" || "/contact/thank_you")
     }) if defined?(::Page)
  end
end