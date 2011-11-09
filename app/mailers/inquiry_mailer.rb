class InquiryMailer < ActionMailer::Base

  def confirmation(inquiry, request)
    subject     InquirySetting.confirmation_subject(Globalize.locale)
    recipients  inquiry.email
    from        "\"#{::Refinery::Setting[:site_name]}\" <no-reply@#{request.domain(::Refinery::Setting.find_or_set(:tld_length, 1))}>"
    reply_to    InquirySetting.notification_recipients.split(',').first
    sent_on     Time.now
    @inquiry =  inquiry
  end

  def notification(inquiry, request)
    subject     InquirySetting.notification_subject
    recipients  InquirySetting.notification_recipients
    from        "\"#{::Refinery::Setting[:site_name]}\" <no-reply@#{request.domain(::Refinery::Setting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @inquiry =  inquiry
  end

end
