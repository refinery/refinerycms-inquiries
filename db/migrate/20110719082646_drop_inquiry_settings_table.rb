class DropInquirySettingsTable < ActiveRecord::Migration
  def self.up
    if ::Refinery::InquirySetting.table_exists?
      drop_table ::Refinery::InquirySetting.table_name
    end
  end

  def self.down
    # we don't want to restore inquiry settings table
  end
end
