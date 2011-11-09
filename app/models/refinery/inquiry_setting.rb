module ::Refinery
  class InquirySetting < ActiveRecord::Base
    def self.column(name, sql_type = nil, default = nil, null = true)
      columns << ActiveRecord::ConnectionAdapters::Column.new( name.to_s, default, sql_type.to_s, null )
    end

    def self.columns()
      @columns ||= [];
    end

    def self.columns_hash
      h = {}
      for c in self.columns
        h[c.name] = c
      end
      return h
    end

    def self.column_defaults
      Hash[self.columns.map{ |col|
        [col.name, col.default]
      }]
    end
      
    def self.descends_from_active_record?
      return true
    end
        
    def persisted?
      return false
    end
        
    # override the save method to prevent exceptions
    def save( validate = true )
      validate ? valid? : true
    end
    class << self
      def confirmation_body
        ::Refinery::Setting.find_or_set(:inquiry_confirmation_body,
          "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm we have received your inquiry and we'll be in touch shortly.\n\nThanks."
        )
      end

      def confirmation_subject(locale='en')
        ::Refinery::Setting.find_or_set("inquiry_confirmation_subject_#{locale}".to_sym,
                                    "Thank you for your inquiry")
      end

      def confirmation_subject=(value)
        value.first.keys.each do |locale|
          ::Refinery::Setting.set("inquiry_confirmation_subject_#{locale}".to_sym, value.first[locale.to_sym])
        end
      end

      def confirmation_message(locale='en')
        ::Refinery::Setting.find_or_set("inquiry_confirmation_messeage_#{locale}".to_sym,
                                    ::Refinery::Setting[:inquiry_confirmation_body])
      end

      def confirmation_message=(value)
        value.first.keys.each do |locale|
          ::Refinery::Setting.set("inquiry_confirmation_messeage_#{locale}".to_sym, value.first[locale.to_sym])
        end
      end

      def notification_recipients
        ::Refinery::Setting.find_or_set(:inquiry_notification_recipients,
                                    ((Role[:refinery].users.first.email rescue nil) if defined?(Role)).to_s)
      end

      def notification_subject
        ::Refinery::Setting.find_or_set(:inquiry_notification_subject,
                                    "New inquiry from your website")
      end

      def send_confirmation?
        ::Refinery::Setting.find_or_set(:inquiry_send_confirmation, true)
      end
    end

  end
end
