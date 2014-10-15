class CreateInquiries < ActiveRecord::Migration
  def up
    unless ::Refinery::Inquiries::Inquiry.table_exists?
      create_table :refinery_inquiries_inquiries, :force => true do |t|
        t.string   :name
        t.string   :email
        t.string   :phone
        t.text     :message
        t.boolean  :spam,     :default => false
        t.timestamps
      end

      add_index :refinery_inquiries_inquiries, :id
    end
  end

  def down
     drop_table ::Refinery::Inquiries::Inquiry.table_name

     ::Refinery::Page.delete_all({
       :link_url => (Refinery::Inquiries.page_url_new || Refinery::Inquiries.page_url_thank_you)
     }) if defined?(::Refinery::Page)
  end
end
