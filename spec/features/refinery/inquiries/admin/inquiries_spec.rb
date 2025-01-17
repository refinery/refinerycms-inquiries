require "spec_helper"

module Refinery
  module Inquiries
    module Admin

      describe Inquiry, :type => :feature do
        refinery_login

        let(:inquiry) do
          FactoryBot.create(:inquiry,
                            :name => "David Jones",
                            :email => "dave@refinerycms.com",
                            :message => "Hello, I really like your website. Was it hard to build and maintain or could anyone do it?")
        end

        let(:delete_first_inquiry){ find_link("Remove this inquiry forever", match: :first).click }

        context "when there are no inquiries" do
          before { Refinery::Inquiries::Inquiry.destroy_all }

          context "inquiries" do
            it "shows message" do
              visit refinery.inquiries_admin_inquiries_path

              expect(page).to have_content("You have not received any inquiries yet.")
            end
          end

          context "spam inquiries" do
            it "shows message" do
              visit refinery.spam_inquiries_admin_inquiries_path

              expect(page).to have_content("Hooray! You don't have any spam.")
            end
          end
        end

        describe "action links" do
          before { visit refinery.inquiries_admin_inquiries_path }

          specify "in the side pane" do
            within "#actions" do
              expect(page).to have_content("Inbox")
              expect(page).to have_selector("a[href='/#{Refinery::Core.backend_route}/inquiries']")
              expect(page).to have_content("Spam")
              expect(page).to have_selector("a[href='/#{Refinery::Core.backend_route}/inquiries/spam']")
              expect(page).to have_content("Update who gets notified")
              expect(page).to have_selector("a[href*='/#{Refinery::Core.backend_route}/inquiries/settings/inquiry_notification_recipients/edit']")
              expect(page).to have_content("Edit confirmation email")
              expect(page).to have_selector("a[href*='/#{Refinery::Core.backend_route}/inquiries/settings/inquiry_confirmation_body/edit']")
            end
          end
        end

        context "when there are inquiries" do
          before { inquiry }

          describe "index" do
            it "shows a list of inquiries" do
              visit refinery.inquiries_admin_inquiries_path
              expect(page).to have_content("David Jones said Hello, I really like your website. Was it hard to build a...")
            end
          end

          describe "show" do
            it "shows inquiry details" do
              visit refinery.inquiries_admin_inquiries_path
              find_link("Read the inquiry", match: :first).click

              expect(page).to have_content("From David Jones [dave@refinerycms.com]")
              expect(page).to have_content("Hello, I really like your website. Was it hard to build and maintain or could anyone do it?")
              within "#actions" do
                expect(page).to have_content("Age")
                expect(page).to have_content("Back to all Inquiries")
                expect(page).to have_selector("a[href='/#{Refinery::Core.backend_route}/inquiries']")
                expect(page).to have_content("Remove this inquiry forever")
                expect(page).to have_selector("a[href='/#{Refinery::Core.backend_route}/inquiries/#{inquiry.id}']")
              end
            end
          end

          describe "destroy" do


            it "removes inquiry" do
              visit refinery.inquiries_admin_inquiries_path

              expect { delete_first_inquiry }.to change(Refinery::Inquiries::Inquiry, :count).by(-1)
              expect(page).to have_content("'#{inquiry.name}' was successfully removed.")

            end
          end

          describe "spam" do
            it "moves inquiry to spam" do
              visit refinery.inquiries_admin_inquiries_path

              find_link("Mark as spam", match: :first).click

              within "#actions" do
                expect(page).to have_content("Spam (1)")
                click_link "Spam (1)"
              end

              expect(page).to have_content("David Jones said Hello, I really like your website. Was it hard to build a...")
            end
          end
        end

        describe "update who gets notified" do
          it "sets receiver", :js => true do
            visit refinery.inquiries_admin_inquiries_path
            find_link("update_notified").click

            within_frame "dialog_iframe" do
              fill_in "setting_value", :with => "phil@refinerycms.com"
              click_button "submit_button"
            end

            expect(page).to have_content("Notification Recipients was successfully updated.")
          end
        end

        describe "updating confirmation email copy" do
          it "sets message", :js => true do
            visit refinery.inquiries_admin_inquiries_path

            find_link("edit_confirmation_email").click

            within_frame "dialog_iframe" do
              fill_in "setting[subject[en]]", :with => "subject"
              fill_in "setting[message[en]]", :with => "message"
              click_button "Save"
            end

            expect(page).to have_content("Confirmation Body was successfully updated.")
          end
        end

      end
    end
  end
end
