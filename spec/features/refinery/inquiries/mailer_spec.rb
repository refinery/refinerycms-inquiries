require "spec_helper"
require "capybara/email/rspec"

module Refinery
  module Inquiries
    describe "mailer", :type => :feature do
      before do
        FactoryGirl.create(:page, :link_url => Refinery::Inquiries.page_path_new)

        allow(ActionMailer::Base).to receive(:delivery_method).and_return(:test)
        allow(Refinery::Inquiries::Setting).to receive(:notification_recipients)
          .and_return("rspec@refinerycms.com")

        clear_emails

        visit refinery.inquiries_new_inquiry_path

        fill_in "Name", with: "Ugis Ozols"
        fill_in "Email", with: "ugis.ozols@refinerycms.com"
        fill_in "Message", with: "Hey, I'm testing!"
        click_button "Send message"
      end

      it "sends confirmation email" do
        open_email("ugis.ozols@refinerycms.com")

        expect(current_email.from).to eq(["#{Refinery::Inquiries.from_name}@example.com"])
        expect(current_email.to).to eq(["ugis.ozols@refinerycms.com"])
        expect(current_email.subject).to eq("Thank you for your inquiry")
        expect(current_email.body).to eq("Thank you for your inquiry Ugis Ozols,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks.")
      end

      it "sends notification email" do
        open_email("rspec@refinerycms.com")

        expect(current_email.from).to eq(["#{Refinery::Inquiries.from_name}@example.com"])
        expect(current_email.to).to eq(["rspec@refinerycms.com"])
        expect(current_email.subject).to eq("New inquiry from your website")
        expect(current_email.body).to eq("Hi there,\n\nYou just received a new inquiry on your website.\n\n--- inquiry starts ---\n\nFrom: Ugis Ozols\nEmail: ugis.ozols@refinerycms.com\nPhone: \nMessage:\nHey, I'm testing!\n\n--- inquiry ends ---\n\nKind Regards,\nCompany Name\n\nP.S. All your inquiries are stored in the \"Inquiries\" section of Refinery should you ever want to view it later there.")
      end
    end
  end
end
