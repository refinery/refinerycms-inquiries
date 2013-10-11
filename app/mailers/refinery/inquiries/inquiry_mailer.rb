module Refinery
  module Inquiries
    class InquiryMailer < ActionMailer::Base

      def confirmation(inquiry, request)
        @inquiry = inquiry
        mail :subject   => Refinery::Inquiries::Setting.confirmation_subject(Globalize.locale),
             :to        => inquiry.email,
             :from      => from_field_for(@inquiry, request),
             :reply_to  => Refinery::Inquiries::Setting.notification_recipients.split(',').first
      end

      def notification(inquiry, request)
        @inquiry = inquiry
        mail :subject   => Refinery::Inquiries::Setting.notification_subject,
             :to        => Refinery::Inquiries::Setting.notification_recipients,
             :from      => from_field_for(@inquiry, request),
             :reply_to  => inquiry.email
      end
      
      private
      
      def from_field_for(inquiry, request)
        ::I18n.t('from_name',
                 :scope => 'refinery.inquiries.config',
                 :site_name => Refinery::Core.site_name,
                 :name => inquiry.name) + " <#{Refinery::Inquiries.from_name}@#{request.domain}>"
      end
      
    end
  end
end
