module Refinery
  class InquiriesGenerator < Rails::Generators::Base
    def rake_db
      rake("refinery_inquiries:install:migrations")
    end
  end
end
