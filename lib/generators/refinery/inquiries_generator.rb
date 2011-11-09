module Refinery
  class InquiriesGenerator < Rails::Generators::Base
    def rake_db
      rake("refinery_inquiries:install:migrations")
    end

    def append_load_seed_data
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by RefineryCMS Inquiries engine
Refinery::Inquiries::Engine.load_seed
        EOH
      end
    end

  end
end
