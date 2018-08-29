require "spec_helper"
require "capybara/email/rspec"

module Refinery
  module Inquiries
    describe "mailer", :type => :feature do
      before do
        FactoryBot.create(:page, :link_url => Refinery::Inquiries.page_path_new)

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

      it_has_behaviour 'sends emails'

      describe "filter_spam" do
        context "when filter_spam setting is set to false" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:filter_spam).and_return(false)
          end

          it_has_behaviour 'sends emails'
        end
      end
    end
  end
end
