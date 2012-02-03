module Refinery
  module Inquiries
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Inquiries

      initializer "init plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_inquiries"
          plugin.url = {:controller => '/refinery/inquiries/admin/inquiries'}
          plugin.menu_match = %r{/refinery/inquiries(/.+?)?$}
          plugin.activity = {
            :class_name => :'refinery/inquiries/inquiry',
            :title => 'name',
            :url_prefix => nil,
            :url => 'refinery.inquiries_admin_inquiries_path'
          }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Inquiries)
      end
    end
  end
end
