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

      context "when given valid data" do
        it "is successful" do
          visit refinery.inquiries_new_inquiry_path
          expect { making_an_inquiry("Ugis Ozols", "ugis.ozols@refinerycms.com", "Hey, I'm testing!") }.to change(Refinery::Inquiries::Inquiry, :count).by(1)
          expect(page.current_path).to eq(refinery.thank_you_inquiries_inquiries_path)
          expect(page).to have_content("Thank You")

          within "#body_content" do
            expect(page).to have_content("We've received your inquiry and will get back to you with a response shortly.")
            expect(page).to have_content("Return to the home page")
            expect(page).to have_selector("a[href='/']")
          end
        end
      end

      context "when given invalid data" do

        it "does not save the inquiry" do
          visit refinery.inquiries_new_inquiry_path
          expect { making_an_inquiry('my name 😀 ', 'jun!k@ok', '☄︎☀︎☽ ') }.not_to change(Refinery::Inquiries::Inquiry, :count)
          expect(page).to have_content("Email is invalid")
        end

      end

      describe 'configuration' do
        describe "privacy" do
          context "when 'show contact privacy link' setting is false" do
            before(:each) do
              allow(Refinery::Inquiries.config).to receive(:show_contact_privacy_link).and_return(false)
            end

            it "won't show link" do
              visit refinery.inquiries_new_inquiry_path

              expect(page).to have_no_content("We value your privacy")
              expect(page).to have_no_selector("a[href='/privacy-policy']")
            end
          end

          context "when' show contact privacy link' setting is true" do
            before(:each) do
              allow(Refinery::Inquiries.config).to receive(:show_contact_privacy_link).and_return(true)
            end

            it "shows the link" do
              visit refinery.inquiries_new_inquiry_path

              expect(page).to have_content("We value your privacy")
              expect(page).to have_selector("a[href='/privacy-policy']")
            end

            context 'when privacy_link has been set to another page' do
              before(:each) do
                allow(Refinery::Inquiries.config).to receive(:privacy_link).and_return('/corporate/privacy')
              end

              it "has a link to the configured page" do
                visit refinery.inquiries_new_inquiry_path

                expect(page).to have_selector("a[href='/corporate/privacy']")
              end
            end
          end
        end

        describe "placeholders" do
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
          context "when 'show phone numbers' setting is false" do
            before(:each) do
              allow(Refinery::Inquiries.config).to receive(:show_phone_number_field).and_return(false)
            end

            it "won't have an input field for phone number" do
              visit refinery.inquiries_new_inquiry_path

              expect(page).to have_no_selector("label", :text => 'Phone')
              expect(page).to have_no_selector("#inquiry_phone")
            end
          end

          context "when 'show phone numbers' setting is true" do
            before(:each) do
              allow(Refinery::Inquiries.config).to receive(:show_phone_number_field).and_return(true)
            end

            it "there is an input field for phone number" do
              visit refinery.inquiries_new_inquiry_path

              expect(page).to have_selector("label", :text => 'Phone')
              expect(page).to have_selector("#inquiry_phone")
            end
          end
        end

        describe "company" do
          context "when 'show company' setting is false" do
            before(:each) do
              allow(Refinery::Inquiries.config).to receive(:show_company_field).and_return(false)
            end

            it "won't show company" do
              visit refinery.inquiries_new_inquiry_path

              expect(page).to have_no_selector("label", :text => 'Company')
              expect(page).to have_no_selector("#inquiry_company")
            end
          end

          context "when 'show company' setting is true" do
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
end

