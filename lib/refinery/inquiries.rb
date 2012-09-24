require 'refinerycms-core'
require 'refinerycms-settings'

module Refinery
  autoload :InquiriesGenerator, 'generators/refinery/inquiries/inquiries_generator'

  module Inquiries
    require 'refinery/inquiries/engine'
    require 'refinery/inquiries/configuration'

    autoload :Version, 'refinery/inquiries/version'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
