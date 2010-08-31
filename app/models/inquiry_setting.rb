class InquirySetting < ActiveRecord::Base

  def self.confirmation_body
    RefinerySetting.find_or_set(:inquiry_confirmation_body,
      "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks."
    )
  end

  def self.confirmation_subject
    RefinerySetting.find_or_set(:inquiry_confirmation_subject,
                                "Thank you for your inquiry")
  end

  def self.confirmation_subject=(value)
    RefinerySetting[:inquiry_confirmation_subject] = value
  end

  def self.notification_recipients
    RefinerySetting.find_or_set(:inquiry_notification_recipients,
                                (defined?(Role) ? Role[:refinery].users.first.email : '' rescue ''))
  end

  def self.notification_subject
    RefinerySetting.find_or_set(:inquiry_notification_subject,
                                "New inquiry from your website")
  end

end
