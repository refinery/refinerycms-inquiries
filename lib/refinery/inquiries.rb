require 'refinerycms-core'
require 'filters_spam'

module Refinery
  autoload :InquiriesGenerator, 'generators/refinery/inquiries_generator'

  module Inquiries
    require 'refinery/inquiries/engine' if defined?(Rails)

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
