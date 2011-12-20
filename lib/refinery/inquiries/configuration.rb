module Refinery
  module Inquiries
    include ActiveSupport::Configurable

    config_accessor :show_contact_privacy_link

    self.show_contact_privacy_link = true
  end
end
