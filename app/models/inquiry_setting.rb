class InquirySetting < ActiveRecord::Base

  def self.confirmation_body
    RefinerySetting.find_or_set(:inquiry_confirmation_body,
      "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks."
    )
  end

  def self.confirmation_subject(locale='en')
    RefinerySetting.find_or_set("inquiry_confirmation_subject_#{locale}".to_sym,
                                "Thank you for your inquiry")
  end

  def self.confirmation_subject=(value)
    value.first.keys.each do |locale|
      RefinerySetting.set("inquiry_confirmation_subject_#{locale}".to_sym, value.first[locale.to_sym])
    end
  end
  
  def self.confirmation_message(locale='en')
    RefinerySetting.find_or_set("inquiry_confirmation_messeage_#{locale}".to_sym,
                                RefinerySetting[:inquiry_confirmation_body])
  end

  def self.confirmation_message=(value)
    value.first.keys.each do |locale|
      RefinerySetting.set("inquiry_confirmation_messeage_#{locale}".to_sym, value.first[locale.to_sym])
    end
  end
  
  def self.notification_recipients
    RefinerySetting.find_or_set(:inquiry_notification_recipients,
                                ((Role[:refinery].users.first.email rescue nil) if defined?(Role)).to_s)
  end

  def self.notification_subject
    RefinerySetting.find_or_set(:inquiry_notification_subject,
                                "New inquiry from your website")
  end

end
