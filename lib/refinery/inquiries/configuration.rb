module Refinery
  module Inquiries
    include ActiveSupport::Configurable

    config_accessor :show_contact_privacy_link
    config_accessor :show_phone_number_field
    config_accessor :show_placeholders
    config_accessor :send_notifications_for_inquiries_marked_as_spam
    config_accessor :from_name
    config_accessor :page_url_new, :page_url_thank_you

    self.show_contact_privacy_link = true
    self.show_phone_number_field = true
    self.show_placeholders = true
    self.send_notifications_for_inquiries_marked_as_spam = false
    self.from_name = "no-reply"
    self.page_url_new = "/contact"
    self.page_url_thank_you = "/contact/thank_you"
  end
end
