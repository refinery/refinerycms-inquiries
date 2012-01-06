require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe InquiryMailer do
  
  let(:inquiry) { FactoryGirl.build(:inquiry) }
  
  describe 'notification' do

    let(:notification) { InquiryMailer.notification(inquiry, double("request", :domain => "refinerycms.com") ) }

    it 'has the correct headers' do
      notification.subject.should == InquirySetting.notification_subject
      notification.reply_to.first.should == inquiry.email
      notification.from.split("<").last.chop.should == "no-reply@refinerycms.com"
    end

  end

end