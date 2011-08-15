require "spec_helper"

describe "manage inquiries" do
  login_refinery_user

  let!(:inquiry) do
    Factory(:inquiry, :name => "David Jones",
                      :email => "dave@refinerycms.com",
                      :message => "Hello, I really like your website.  Was it hard to build and maintain or could anyone do it?")    
  end

  context "when no" do
    before(:each) { Refinery::Inquiry.destroy_all }

    context "inquiries" do
      it "shows message" do
        visit refinery_admin_inquiries_path

        page.should have_content("You have not received any inquiries yet.")
      end
    end

    context "spam inquiries" do
      it "shows message" do
        visit spam_refinery_admin_inquiries_path

        page.should have_content("Hooray! You don't have any spam.")
      end
    end
  end

  describe "action links" do
    before(:each) { visit refinery_admin_inquiries_path }

    specify "in the side pane" do
      within "#actions" do
        page.should have_content("Inbox")
        page.should have_selector("a[href='/refinery/inquiries']")
        page.should have_content("Spam")
        page.should have_selector("a[href='/refinery/inquiries/spam']")
        page.should have_content("Update who gets notified")
        page.should have_selector("a[href*='/refinery/inquiry_settings/inquiry_notification_recipients/edit']")
        page.should have_content("Edit confirmation email")
        page.should have_selector("a[href*='/refinery/inquiry_settings/inquiry_confirmation_body/edit']")
      end
    end
  end

  describe "index" do
    it "shows inquiry list" do
      visit refinery_admin_inquiries_path

      page.should have_content("David Jones said Hello, I really like your website. Was it hard to build ...")
    end
  end

  describe "show" do
    it "shows inquiry details" do
      visit refinery_admin_inquiries_path

      click_link "Read the inquiry"

      page.should have_content("From David Jones [dave@refinerycms.com]")
      page.should have_content("Hello, I really like your website. Was it hard to build and maintain or could anyone do it?")
      within "#actions" do
        page.should have_content("Age")
        page.should have_content("Back to all Inquiries")
        page.should have_selector("a[href='/refinery/inquiries']")
        page.should have_content("Remove this inquiry forever")
        page.should have_selector("a[href='/refinery/inquiries/#{inquiry.id}']")
      end
    end
  end

  describe "destroy" do
    it "removes inquiry" do
      visit refinery_admin_inquiries_path

      click_link "Remove this inquiry forever"

      page.should have_content("'#{inquiry.name}' was successfully removed.")
      Refinery::Inquiry.count.should == 0
    end
  end

  describe "spam" do
    it "moves inquiry to spam" do
      visit refinery_admin_inquiries_path

      click_link "Mark as spam"

      within "#actions" do
        page.should have_content("Spam (1)")
        click_link "Spam (1)"
      end

      page.should have_content("David Jones said Hello, I really like your website. Was it hard to build ...")
    end
  end

=begin
  describe "update who gets notified" do
    it "sets receiver", :js => true do
      visit refinery_admin_inquiries_path

      click_link "Update who gets notified"

      within_frame "dialog_iframe" do
        fill_in "Send notifications to", :with => "phil@refinerycms.com"
        click_button "Save"
      end

      page.should have_content("'Notification Recipients' was successfully updated.")
    end
  end

  describe "updating confirmation email copy" do
    it "sets message", :js => true do
      visit refinery_admin_inquiries_path

      click_link "Edit confirmation email"

      within_frame "dialog_iframe" do
        fill_in "Message", :with => "Thanks %name%! We'll never get back to you!"
        click_button "Save"
      end

      page.should have_content("'Confirmation Body' was successfully updated.")
    end
  end
=end
end
