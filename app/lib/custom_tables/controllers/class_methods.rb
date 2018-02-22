module CustomTables
module Controllers
  module ClassMethods

    def has_custom_index(config={})
      send(:include, InstanceMethods)
      @index_headers = config[:default_headers]
      before_action :set_default_headers, :only => [:index] + config.fetch(:additional_before_actions, [])
      define_method "set_default_headers" do
        resource_class = params[:controller].classify.underscore
        @default_headers = config.fetch(:default_headers, [])
        @translation_base = config.fetch(:translation_base, resource_class)
      end
    end


    module InstanceMethods

    end

  end
end
end