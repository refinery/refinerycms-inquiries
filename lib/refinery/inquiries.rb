require 'refinerycms-core'
require 'filters_spam'

module Refinery
  module Inquiries
    require 'refinery/inquiries/engine' if defined?(Rails)

    autoload :Version, 'refinery/inquiries/version'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def version
        Refinery::Inquiries::Version.to_s
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
