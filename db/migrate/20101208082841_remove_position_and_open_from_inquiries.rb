class RemovePositionAndOpenFromInquiries < ActiveRecord::Migration
  def self.up
    remove_column :inquiries, :position
    remove_column :inquiries, :open
  end

  def self.down
    add_column :inquiries, :position, :integer
    add_column :inquiries, :open,     :boolean, :default => true
  end
end
