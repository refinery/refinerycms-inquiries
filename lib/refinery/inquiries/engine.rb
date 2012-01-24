require 'refinerycms-inquiries'

module Refinery
  module Inquiries
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery
      engine_name :refinery_inquiries

      initializer "register refinerycms_inquiries plugin", :after => :set_routes_reloader do |app|
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_inquiries"
          plugin.url = {:controller => '/refinery/admin/inquiries'}
          plugin.menu_match = %r{refinery/inquir(ies|y_settings)(/.+?)?$}
          plugin.activity = {
            :class_name => :'refinery/inquiry',
            :title => 'name',
            :url_prefix => nil,
            :url => 'refinery_admin_inquiries_path'
          }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Inquiries)
      end
    end
  end
end
