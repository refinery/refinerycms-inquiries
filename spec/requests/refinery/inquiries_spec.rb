# encoding: utf-8
require 'spec_helper'

module Refinery
  describe 'inquiries frontend' do
    before(:each) do
      # So that we can use Refinery.
      FactoryGirl.create(:refinery_user)

      # Create some pages for these specs
      FactoryGirl.create(:page, :title => 'Contact Us', :link_url => '/contact')
      FactoryGirl.create(:page, :title => 'Thank You', :link_url => '/contact/thank_you')
    end
    
    describe 'new/create' do
      it "allows to create inquiry with valid arguments" do
        visit '/contact'
        
        fill_in "Name *", :with => "Philip"
        fill_in "Email *", :with => "phil@refinerycms.com"
        fill_in "Message *", :with => "It sure is good to have a functional test coverage."
        click_button "Send"
      end
    
      it "doesn't allows to create inquiry with invalid arguments" do
        visit '/contact'
        
        click_button "Send"
        
        page.should have_content("Name can't be blank")
        page.should_not have_content("Email can't be blank")
        page.should have_content("Email is invalid")
        page.should_not have_content("Phone can't be blank")
        page.should have_content("Message can't be blank")
        
        Refinery::Inquiry.count.should == 0
      end
    end
  end
end
