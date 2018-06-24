class AddCompanyToRefineryInquiriesInquiry < ActiveRecord::Migration[4.2]
  def up
    add_column :refinery_inquiries_inquiries, :company, :string
  end

  def down
    remove_column :refinery_inquiries_inquiries, :company
  end
end
