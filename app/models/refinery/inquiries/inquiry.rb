require 'refinery/core/base_model'
require 'filters_spam'

module Refinery
  module Inquiries
    class Inquiry < Refinery::Core::BaseModel

      filters_spam message_field:    :message,
                   email_field:      :email,
                   author_field:     :name,
                   other_fields:     [:phone],
                   extra_spam_words: %w()

      validates :name, presence: true
      validates :email, format: {
        with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      }
      validates :message, presence: true

      default_scope { order('created_at DESC') }

      attr_accessible :name, :phone, :message, :email

      def self.latest(number = 7, include_spam = false)
        include_spam ? limit(number) : ham.limit(number)
      end

    end
  end
end
