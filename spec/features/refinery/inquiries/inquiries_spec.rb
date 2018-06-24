require "spec_helper"

module Refinery
  module Inquiries
    describe "inquiries", :type => :feature do
      before do
        # load in seeds we use in migration
        Refinery::Inquiries::Engine.load_seed
      end

      it "posts to the correct URL" do
        visit refinery.inquiries_new_inquiry_path
        expect(page).to have_selector("form[action='#{refinery.inquiries_inquiries_path}']")
      end

      context "when valid data" do
        it "is successful" do
          visit refinery.inquiries_new_inquiry_path

          fill_in "Name", :with => "Ugis Ozols"
          fill_in "Email", :with => "ugis.ozols@refinerycms.com"
          fill_in "Message", :with => "Hey, I'm testing!"
          click_button "Send message"

          expect(page.current_path).to eq(refinery.thank_you_inquiries_inquiries_path)
          expect(page).to have_content("Thank You")

          within "#body_content" do
            expect(page).to have_content("We've received your inquiry and will get back to you with a response shortly.")
            expect(page).to have_content("Return to the home page")
            expect(page).to have_selector("a[href='/']")
          end

          expect(Refinery::Inquiries::Inquiry.count).to eq(1)
        end
      end

      context "when invalid data" do
        let(:name_error_message) { "Name can't be blank" }
        let(:email_error_message) { "Email is invalid" }
        let(:message_error_message) { "Message can't be blank" }

        it "is not successful" do
          visit refinery.inquiries_new_inquiry_path

          click_button "Send message"

          expect(page.current_path).to eq(refinery.inquiries_inquiries_path)
          expect(page).to have_content("There were problems with the following fields")
          expect(page).to have_content(name_error_message)
          expect(page).to have_content(email_error_message)
          expect(page).to have_content(message_error_message)
          expect(page).to have_no_content("Phone can't be blank")
          expect(page).to have_no_content("Company can't be blank")

          expect(Refinery::Inquiries::Inquiry.count).to eq(0)
        end

        it "displays the error messages in the same order as the fields" do
          visit refinery.inquiries_new_inquiry_path

          click_button "Send message"

          expect(page).to have_content(/#{name_error_message}.+#{email_error_message}.+#{message_error_message}/m)
        end
      end

      describe "privacy" do
        context "when show contact privacy link setting set to false" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_contact_privacy_link).and_return(false)
          end

          it "won't show link" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_no_content("We value your privacy")
            expect(page).to have_no_selector("a[href='/privacy-policy']")
          end
        end

        context "when show contact privacy link setting set to true" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_contact_privacy_link).and_return(true)
          end

          it "shows the link" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_content("We value your privacy")
            expect(page).to have_selector("a[href='/privacy-policy']")
          end
        end
      end

      describe "palceholders" do
        context "when show placeholders setting set to false" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_placeholders).and_return(false)
          end

          it "won't show placeholders" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_no_selector("input[placeholder]")
          end
        end

        context "when show placeholders setting set to true" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_placeholders).and_return(true)
          end

          it "shows the placeholders" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_selector("input[placeholder]")
          end
        end
      end

      describe "phone number" do
        context "when show phone numbers setting set to false" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_phone_number_field).and_return(false)
          end

          it "won't show phone number" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_no_selector("label", :text => 'Phone')
            expect(page).to have_no_selector("#inquiry_phone")
          end
        end

        context "when show phone numbers setting set to true" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_phone_number_field).and_return(true)
          end

          it "shows the phone number" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_selector("label", :text => 'Phone')
            expect(page).to have_selector("#inquiry_phone")
          end
        end
      end

      describe "company" do
        context "when show company setting set to false" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_company_field).and_return(false)
          end

          it "won't show company" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_no_selector("label", :text => 'Company')
            expect(page).to have_no_selector("#inquiry_company")
          end
        end

        context "when show company setting set to true" do
          before(:each) do
            allow(Refinery::Inquiries.config).to receive(:show_company_field).and_return(true)
          end

          it "shows the company" do
            visit refinery.inquiries_new_inquiry_path

            expect(page).to have_selector("label", :text => 'Company')
            expect(page).to have_selector("#inquiry_company")
          end
        end
      end
    end
  end
end
