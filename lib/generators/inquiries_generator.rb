require 'refinery/generators'

module ::Refinery
  class InquiriesGenerator < Refinery::Generators::EngineInstaller

    source_root File.expand_path('../../../', __FILE__)
    engine_name "refinery_inquiries"

  end
end
