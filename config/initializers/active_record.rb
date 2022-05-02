module PolymorphicBelongsTo
  def valid_options(options)
    valid = super + [:polymorphic, :counter_cache, :optional, :default]
    valid += [:foreign_type] if options[:polymorphic]
    valid += [:ensuring_owner_was] if options[:dependent] == :destroy_async
    valid
  end
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Associations::Builder::BelongsTo.extend PolymorphicBelongsTo
end
