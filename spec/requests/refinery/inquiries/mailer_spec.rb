require "spec_helper"
require "capybara/email/rspec"

module Refinery
  module Inquiries
    describe "mailer" do
      before do
        FactoryGirl.create(:page, :link_url => "/contact")

        Refinery::Inquiries::Setting.stub(:notification_recipients).and_return("rspec@refinerycms.com")

        clear_emails

        visit refinery.inquiries_new_inquiry_path

        fill_in "Name", :with => "Ugis Ozols"
        fill_in "Email", :with => "ugis.ozols@refinerycms.com"
        fill_in "Message", :with => "Hey, I'm testing!"
        click_button "Send message"
      end

      it "sends confirmation email" do
        open_email("ugis.ozols@refinerycms.com")

        current_email.from.should eq(["no-reply@example.com"])
        current_email.to.should eq(["ugis.ozols@refinerycms.com"])
        current_email.subject.should eq("Thank you for your inquiry")
        current_email.body.should eq("Thank you for your inquiry Ugis Ozols,\r\n\r\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\r\n\r\nThanks.")
      end

      it "sends notification email" do
        open_email("rspec@refinerycms.com")

        current_email.from.should eq(["no-reply@example.com"])
        current_email.to.should eq(["rspec@refinerycms.com"])
        current_email.subject.should eq("New inquiry from your website")
        current_email.body.should eq("Hi there,\r\n\r\nYou just received a new inquiry on your website.\r\n\r\n--- inquiry starts ---\r\n\r\nFrom: Ugis Ozols\r\nEmail: ugis.ozols@refinerycms.com\r\nPhone: \r\nMessage:\r\nHey, I&#x27;m testing!\r\n\r\n--- inquiry ends ---\r\n\r\nKind Regards,\r\nCompany Name\r\n\r\nP.S. All your inquiries are stored in the \"Inquiries\" section of Refinery should you ever want to view it later there.")
      end
    end
  end
end
