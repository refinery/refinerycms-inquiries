require File.expand_path('../inquiries', __FILE__)
require File.expand_path('../generators/inquiries_generator', __FILE__)

module Refinery
  module Inquiries
    class Engine < Rails::Engine
      isolate_namespace Refinery

      config.to_prepare do
        require 'filters_spam'
      end

      initializer "init plugin", :after => :set_routes_reloader do |app|
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_inquiries"
          plugin.directory = "inquiries"
          plugin.menu_match = /refinery\/inquir(ies|y_settings)$/
          plugin.url = app.routes.url_helpers.refinery_admin_inquiries_path
          plugin.activity = {
            :class => Refinery::InquirySetting,
            :title => 'name'
          }
        end
      end
    end
  end
end
