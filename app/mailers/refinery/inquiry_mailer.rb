module Refinery
  class InquiryMailer < ActionMailer::Base

    def confirmation(inquiry, request)
      @inquiry =  inquiry
      mail :subject   => Refinery::InquirySetting.confirmation_subject(Globalize.locale),
           :to        => inquiry.email,
           :from      => "\"#{Refinery::Setting[:site_name]}\" <no-reply@#{request.domain(Refinery::Setting.find_or_set(:tld_length, 1))}>",
           :reply_to  => Refinery::InquirySetting.notification_recipients.split(',').first
    end

    def notification(inquiry, request)
      @inquiry =  inquiry
      mail :subject => Refinery::InquirySetting.notification_subject,
           :to      => Refinery::InquirySetting.notification_recipients,
           :from    => "\"#{Refinery::Setting[:site_name]}\" <no-reply@#{request.domain(Refinery::Setting.find_or_set(:tld_length, 1))}>"
    end

  end
end
