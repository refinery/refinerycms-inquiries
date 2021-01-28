require 'httpclient'
require 'uri'
require 'English'

module Refinery
  module Inquiries
    class SpamFilter
      def initialize(inquiry, request)
        @inquiry = inquiry
        @request = request
        @params = request.params
      end

      def call
        if recaptcha?
          if recaptcha_validated?
            @valid = true
            @inquiry.save
          else
            @inquiry.errors.add(:base, ::I18n.t(:captcha_invalid, scope: "refinery.inquiries.spam_filter"))
          end
        elsif simple_filter?
          @inquiry.save
          @valid = simple_filter_validated?
        end

        if notify?
          send_notification_email!
          send_confirmation_email!
        end
      end

      def valid?
        @valid == true
      end

      def notify?
        if valid?
          if simple_filter?
            @inquiry.ham? || Inquiries.send_notifications_for_inquiries_marked_as_spam
          else
            true
          end
        end
      end

      def recaptcha_validated?
        return true unless recaptcha?
        # avoid doing a second request if we already have a result.
        return @recaptcha_validated unless @recaptcha_validated.nil?

        @recaptcha_validated = recaptcha_success?
      end

      private

      def recaptcha?
        Inquiries.recaptcha_site_key.present?
      end

      GOOGLE_SITEVERIFY_URL = "https://www.google.com/recaptcha/api/siteverify".freeze
      def recaptcha_success?
        http = HTTPClient.new
        response = http.get(
          GOOGLE_SITEVERIFY_URL,
          secret: Rails.application.secrets.recaptcha_secret_key,
          response: @params["g-recaptcha-response"]
        )
        JSON.parse(response.body)["success"] == true
      end

      def simple_filter?
        Inquiries.filter_spam
      end

      def simple_filter_validated?
        return true unless simple_filter?

        @inquiry.ham?
      end

      def send_notification_email!
        begin
          InquiryMailer.notification(@inquiry, @request).deliver_now
        rescue
          Rails.logger.warn "There was an error delivering an inquiry notification.\n#{$ERROR_INFO}"
        end
      end

      def send_confirmation_email!
        if Setting.send_confirmation?
          begin
            InquiryMailer.confirmation(@inquiry, @request).deliver_now
          rescue
            Rails.logger.warn "There was an error delivering an inquiry confirmation:\n#{$ERROR_INFO}"
          end
        end
      end
    end
  end
end
