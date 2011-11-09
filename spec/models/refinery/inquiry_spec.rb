require 'spec_helper'

Dir[File.expand_path('../../../../features/support/factories.rb', __FILE__)].each {|f| require f}

module Refinery
  describe Inquiry do
    describe "validations" do
      before(:each) do
        @attr = {
          :name => "rspec",
          :email => "rspec@refinery.com",
          :message => "test"
        }
      end

      it "rejects empty name" do
        ::Refinery::Inquiry.new(@attr.merge(:name => "")).should_not be_valid
      end

      it "rejects empty message" do
        ::Refinery::Inquiry.new(@attr.merge(:message => "")).should_not be_valid
      end

      it "rejects invalid email format" do
        ["", "@refinerycms.com", "refinery@cms", "refinery@cms.123"].each do |email|
          ::Refinery::Inquiry.new(@attr.merge(:email => email)).should_not be_valid
        end
      end
    end

    describe "default scope" do
      it "orders by created_at in desc" do
        inquiry1 = Factory(:inquiry, :created_at => 1.hour.ago)
        inquiry2 = Factory(:inquiry, :created_at => 2.hours.ago)
        inquiries = ::Refinery::Inquiry.all
        inquiries.first.should == inquiry1
        inquiries.second.should == inquiry2
      end
    end

    describe ".latest" do
      it "returns latest 7 non-spam inquiries by default" do
        8.times { Factory(:inquiry) }
        ::Refinery::Inquiry.last.toggle!(:spam)
        ::Refinery::Inquiry.latest.length.should == 7
      end

      it "returns latest 7 inquiries including spam ones" do
        4.times { Factory(:inquiry) }
        3.times { Factory(:inquiry) }
        ::Refinery::Inquiry.all[0..2].each { |inquiry| inquiry.toggle!(:spam) }
        ::Refinery::Inquiry.latest(7, true).length.should == 7
      end

      it "returns latest n inquiries" do
        4.times { Factory(:inquiry) }
        ::Refinery::Inquiry.latest(3).length.should == 3
      end
    end
  end
end

