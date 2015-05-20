module Refinery
  module Inquiries
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Inquiries

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_inquiries"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.inquiries_admin_inquiries_path }
          plugin.menu_match = %r{refinery/inquiries(/.+?)?$}
        end

        Rails.application.config.assets.precompile += %w(refinery/inquiries/*)
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Inquiries)
      end
    end
  end
end
