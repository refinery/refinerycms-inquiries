class RemovePositionAndOpenFromInquiries < ActiveRecord::Migration
  def up
    remove_column ::Refinery::Inquiry.table_name, :position
    remove_column ::Refinery::Inquiry.table_name, :open
  end

  def down
    add_column ::Refinery::Inquiry.table_name, :position, :integer
    add_column ::Refinery::Inquiry.table_name, :open,     :boolean, :default => true
  end
end
