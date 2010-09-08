module NavigationHelpers
  module Refinery
    module Inquiries
      def path_to(page_name)
        case page_name
        when /the contact page/
          new_inquiry_path

        when /the contact thank you page/
          thank_you_inquiries_path

        when /the contact create page/
          inquiries_path

        when /the list of inquiries/
          admin_inquiries_path

        when /the list of spam inquiries/
          spam_admin_inquiries_path
        else
          nil
        end
      end
    end
  end
end