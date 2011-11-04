module Refinery
  class InquiriesGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

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
