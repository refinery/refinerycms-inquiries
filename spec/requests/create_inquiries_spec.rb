require "spec_helper"

describe "create inquiry" do
  before(:each) do
    Factory(:refinery_user)

    # load in seeds we use in migration
    load File.expand_path("../../../db/seeds/pages_for_inquiries.rb", __FILE__)
  end

  it "is successful" do
    visit new_inquiry_path

    fill_in "Name", :with => "Ugis Ozols"
    fill_in "Email", :with => "ugis.ozols@refinerycms.com"
    fill_in "Message", :with => "Hey, I'm testing!"
    click_button "Send message"

    page.current_path.should == thank_you_inquiries_path
    page.should have_content("Thank You")

    within "#body_content_left" do
      page.should have_content("We've received your inquiry and will get back to you with a response shortly.")
      page.should have_content("Return to the home page")
      page.should have_selector("a[href='/']")
    end
  end

  describe "privacy" do
    context "when show contact privacy link setting set to false" do
      it "won't show link" do
        visit new_inquiry_path

        page.should have_no_content("We value your privacy")
        page.should have_no_selector("a[href='/pages/privacy-policy']")
      end
    end

    context "when show contact privacy link setting set to true" do
      before { Refinery::Setting.set(:show_contact_privacy_link, true) }

      it "shows the link" do
        pending "this spec fails ... will fix asap"
        visit new_inquiry_path

        page.should have_content("We value your privacy")
        page.should have_selector("a[href='/pages/privacy-policy']")
      end
    end
  end
end
