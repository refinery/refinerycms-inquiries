class InquirySetting < ActiveRecord::Base

  class << self
    def confirmation_body
      ::Refinery::RefinerySetting.find_or_set(:inquiry_confirmation_body,
        "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks."
      )
    end

    def confirmation_subject(locale='en')
      ::Refinery::RefinerySetting.find_or_set("inquiry_confirmation_subject_#{locale}".to_sym,
                                  "Thank you for your inquiry")
    end

    def confirmation_subject=(value)
      value.first.keys.each do |locale|
        ::Refinery::RefinerySetting.set("inquiry_confirmation_subject_#{locale}".to_sym, value.first[locale.to_sym])
      end
    end

    def confirmation_message(locale='en')
      ::Refinery::RefinerySetting.find_or_set("inquiry_confirmation_messeage_#{locale}".to_sym,
                                  RefinerySetting[:inquiry_confirmation_body])
    end

    def confirmation_message=(value)
      value.first.keys.each do |locale|
        ::Refinery::RefinerySetting.set("inquiry_confirmation_messeage_#{locale}".to_sym, value.first[locale.to_sym])
      end
    end

    def notification_recipients
      ::Refinery::RefinerySetting.find_or_set(:inquiry_notification_recipients,
                                  ((Role[:refinery].users.first.email rescue nil) if defined?(Role)).to_s)
    end

    def notification_subject
      ::Refinery::RefinerySetting.find_or_set(:inquiry_notification_subject,
                                  "New inquiry from your website")
    end

    def send_confirmation?
      ::Refinery::RefinerySetting.find_or_set(:inquiry_send_confirmation, true)
    end
  end

end
