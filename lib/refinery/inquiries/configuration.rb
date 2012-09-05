module Refinery
  module Inquiries
    include ActiveSupport::Configurable

    config_accessor :show_contact_privacy_link, :inquiry_from_email

    self.show_contact_privacy_link = true
    self.inquiry_from_email        = "no-reply@localhost"

  end
end