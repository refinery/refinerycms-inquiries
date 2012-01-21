require 'spec_helper'

module Refinery
  describe InquirySetting do
    describe ".confirmation_InquirySetting" do
      it "has a default value" do
        InquirySetting.confirmation_subject.should eq "Thank you for your inquiry"
      end
      context "after setting" do
        let(:message_data) {
            {'en' => 'Confirmation in English',
            'de' => 'Confirmation in German'}
        }

        before {
          message_data.each_pair do |k,v|
            InquirySetting.confirmation_subject= [{k => v}]
          end
        }
        it "returns the 'en' message when called with no parameters" do
          InquirySetting.confirmation_subject.should eq message_data['en']
        end
        it "returns the message for the local passed in" do
          message_data.each_pair do |k,v|
            InquirySetting.confirmation_subject(k).should eq v
          end
        end
      end
    end
  end
end
