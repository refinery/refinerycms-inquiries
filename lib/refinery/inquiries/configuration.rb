module Refinery
  module Inquiries
    include ActiveSupport::Configurable

    config_accessor :show_contact_privacy_link
    config_accessor :show_placeholders

    self.show_contact_privacy_link = true
    self.show_placeholders = true
  end
end
