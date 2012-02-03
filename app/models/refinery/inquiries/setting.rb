module Refinery
  module Inquiries
    class Setting

      class << self
        def confirmation_body
          Refinery::Setting.find_or_set(:inquiry_confirmation_body,
            "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks."
          )
        end

        def confirmation_subject(locale='en')
          Refinery::Setting.find_or_set("inquiry_confirmation_subject_#{locale}".to_sym,
                                        "Thank you for your inquiry",
                                        :scoping => "inquiries")
        end

        def confirmation_subject=(value)
          value.first.keys.each do |locale|
            Refinery::Setting.set("inquiry_confirmation_subject_#{locale}".to_sym, {
                                    :value => value.first[locale.to_sym],
                                    :scoping => "inquiries"
                                  })
          end
        end

        def confirmation_message(locale='en')
          Refinery::Setting.find_or_set("inquiry_confirmation_message_#{locale}".to_sym,
                                        Refinery::Setting[:inquiry_confirmation_body],
                                        :scoping => "inquiries")
        end


        def confirmation_message=(value)
          value.first.keys.each do |locale|
            Refinery::Setting.set("inquiry_confirmation_message_#{locale}".to_sym, {
                                    :value => value.first[locale.to_sym],
                                    :scoping => "inquiries"
                                  })
          end
        end

        def notification_recipients
          Refinery::Setting.find_or_set(:inquiry_notification_recipients,
                                        ((Refinery::Role[:refinery].users.first.email rescue nil) if defined?(Refinery::Role)).to_s,
                                        :scoping => "inquiries")
        end

        def notification_subject
          Refinery::Setting.find_or_set(:inquiry_notification_subject,
                                        "New inquiry from your website",
                                        :scoping => "inquiries")
        end
        
        def send_confirmation?
          Refinery::Setting.find_or_set(:inquiry_send_confirmation, 
                                        true,
                                        :scoping => "inquiries")
        end
      end
    end
  end
end
