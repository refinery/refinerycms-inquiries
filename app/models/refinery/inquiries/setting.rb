require 'refinery/setting'

module Refinery
  module Inquiries
    class Setting < ::Refinery::Setting

      class << self
        def confirmation_body
          find_or_set(:inquiry_confirmation_body,
            "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks."
          )
        end

        def confirmation_subject(locale='en')
          find_or_set(:"inquiry_confirmation_subject_#{locale}",
            "Thank you for your inquiry",
            scoping: "inquiries"
          )
        end

        def confirmation_subject=(value)
          value.first.keys.each do |locale|
            set(:"inquiry_confirmation_subject_#{locale}", {
              value: value.first[locale.to_sym],
              scoping: "inquiries"
            })
          end
        end

        def confirmation_message(locale='en')
          find_or_set(:"inquiry_confirmation_message_#{locale}", confirmation_body, scoping: "inquiries")
        end

        def confirmation_message=(value)
          value.first.keys.each do |locale|
            set(:"inquiry_confirmation_message_#{locale}", {
              value: value.first[locale.to_sym],
              scoping: "inquiries"
            })
          end
        end

        def notification_recipients
          recipients = ((Role[:refinery].users.first.email rescue nil) if defined?(Role)).to_s
          find_or_set(:inquiry_notification_recipients, recipients, scoping: "inquiries")
        end

        def notification_subject
          find_or_set(:inquiry_notification_subject, "New inquiry from your website", scoping: "inquiries")
        end

        def send_confirmation?
          find_or_set(:inquiry_send_confirmation, true, scoping: "inquiries")
        end
      end
    end
  end
end
