require 'spec_helper'

module Refinery
  describe Inquiry do
    describe "validations" do
      subject do
        Factory.build(:inquiry,
                      :name => "Ugis Ozols",
                      :email => "ugis.ozols@refinerycms.com",
                      :message => "Hey, I'm testing!")
      end

      it { should be_valid }
      its(:errors) { should be_empty }
      its(:name) { should == "Ugis Ozols" }
      its(:email) { should == "ugis.ozols@refinerycms.com" }
      its(:message) { should == "Hey, I'm testing!" }
    end

    describe "default scope" do
      it "orders by created_at in desc" do
        inquiry1 = Factory(:inquiry, :created_at => 1.hour.ago)
        inquiry2 = Factory(:inquiry, :created_at => 2.hours.ago)
        inquiries = Refinery::Inquiry.all
        inquiries.first.should == inquiry1
        inquiries.second.should == inquiry2
      end
    end

    describe ".latest" do
      it "returns latest 7 non-spam inquiries by default" do
        8.times { Factory(:inquiry) }
        Refinery::Inquiry.last.toggle!(:spam)
        Refinery::Inquiry.latest.length.should == 7
      end

      it "returns latest 7 inquiries including spam ones" do
        4.times { Factory(:inquiry) }
        3.times { Factory(:inquiry) }
        Refinery::Inquiry.all[0..2].each { |inquiry| inquiry.toggle!(:spam) }
        Refinery::Inquiry.latest(7, true).length.should == 7
      end

      it "returns latest n inquiries" do
        4.times { Factory(:inquiry) }
        Refinery::Inquiry.latest(3).length.should == 3
      end
    end
  end
end
