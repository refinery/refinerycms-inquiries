module Refinery
  class InquiryMailer < ActionMailer::Base

    def confirmation(inquiry, request)
      @inquiry = inquiry
      mail :subject   => Refinery::InquirySetting.confirmation_subject(Globalize.locale),
           :to        => inquiry.email,
           :from      => "\"#{Refinery::Core.config.site_name}\" <no-reply@#{request.domain}>",
           :reply_to  => Refinery::InquirySetting.notification_recipients.split(',').first
    end

    def notification(inquiry, request)
      @inquiry = inquiry
      mail :subject => Refinery::InquirySetting.notification_subject,
           :to      => Refinery::InquirySetting.notification_recipients,
           :from    => "\"#{Refinery::Core.config.site_name}\" <no-reply@#{request.domain}>"
    end

  end
end
