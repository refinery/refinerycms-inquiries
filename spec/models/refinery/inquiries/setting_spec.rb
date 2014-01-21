require 'spec_helper'

module Refinery
  module Inquiries
    describe Setting do
      describe ".notification_recipients=" do
        it "delegates to Refinery::Setting#set" do
          expect(Refinery::Setting).to receive(:set).
            with(:inquiry_notification_recipients, {
              :value=>"some value",
              :scoping=>"inquiries"
            })

          Refinery::Inquiries::Setting.notification_recipients = "some value"
        end
      end
    end
  end
end
