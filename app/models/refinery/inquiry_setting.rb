module Refinery
  class InquirySetting < ActiveRecord::Base

    def self.confirmation_body
      Refinery::RefinerySetting.find_or_set(:inquiry_confirmation_body,
        "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks."
      )
    end

    def self.confirmation_subject(locale='en')
      Refinery::RefinerySetting.find_or_set("inquiry_confirmation_subject_#{locale}".to_sym,
                                  "Thank you for your inquiry")
    end

    def self.confirmation_subject=(value)
      value.first.keys.each do |locale|
        Refinery::RefinerySetting.set("inquiry_confirmation_subject_#{locale}".to_sym, value.first[locale.to_sym])
      end
    end

    def self.confirmation_message(locale='en')
      Refinery::RefinerySetting.find_or_set("inquiry_confirmation_messeage_#{locale}".to_sym,
                                  Refinery::RefinerySetting[:inquiry_confirmation_body])
    end

    def self.confirmation_message=(value)
      value.first.keys.each do |locale|
        Refinery::RefinerySetting.set("inquiry_confirmation_messeage_#{locale}".to_sym, value.first[locale.to_sym])
      end
    end

    def self.notification_recipients
      Refinery::RefinerySetting.find_or_set(:inquiry_notification_recipients,
                                  ((Refinery::Role[:refinery].users.first.email rescue nil) if defined?(Refinery::Role)).to_s)
    end

    def self.notification_subject
      Refinery::RefinerySetting.find_or_set(:inquiry_notification_subject,
                                  "New inquiry from your website")
    end

  end
end