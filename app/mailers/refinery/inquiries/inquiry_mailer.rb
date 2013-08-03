module Refinery
  module Inquiries
    class InquiryMailer < ActionMailer::Base

      def confirmation(inquiry, request)
        @inquiry, @request = inquiry, request
        mail :subject   => Refinery::Inquiries::Setting.confirmation_subject(Globalize.locale),
             :to        => inquiry.email,
             :from      => from_info,
             :reply_to  => Refinery::Inquiries::Setting.notification_recipients.split(',').first
      end

      def notification(inquiry, request)
        @inquiry, @request = inquiry, request
        mail :subject   => Refinery::Inquiries::Setting.notification_subject,
             :to        => Refinery::Inquiries::Setting.notification_recipients,
             :from      => from_info,
             :reply_to  => inquiry.email
      end

      def from_info
        "\"#{from_name}\" <#{from_mail}>"
      end

      def from_name
        :I18n.t('from_name',
                :scope => 'refinery.inquiries.config',
                :site_name => Refinery::Core.site_name,
                :name => @inquiry.name)
      end

      def from_mail
        "#{Refinery::Inquiries.from_name}@#{@request.domain}"
      end
    end
  end
end
