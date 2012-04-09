module Refinery
  class InquiriesGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_inquiries_initializer
      template 'config/initializers/refinery/inquiries.rb.erb', File.join(destination_root, 'config', 'initializers', 'refinery', 'inquiries.rb')
    end

    def rake_db
      rake("refinery_inquiries:install:migrations")
      rake("refinery_settings:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Inquiries engine
Refinery::Inquiries::Engine.load_seed
        EOH
      end
    end
  end
end
