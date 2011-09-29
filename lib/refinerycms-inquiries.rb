require 'filters_spam'
require File.expand_path('../generators/inquiries_generator', __FILE__)

module Refinery
  module Inquiries
    class Engine < Rails::Engine
      isolate_namespace Refinery

      initializer "init plugin", :after => :set_routes_reloader do |app|
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_inquiries"
          plugin.directory = "inquiries"
          plugin.menu_match = /refinery\/inquir(ies|y_settings)$/
          plugin.url = app.routes.url_helpers.refinery_admin_inquiries_path
          plugin.activity = {
            :class => Refinery::Inquiry,
            :title => 'name',
            :url_prefix => nil
          }
        end
      end
    end
  end
end
