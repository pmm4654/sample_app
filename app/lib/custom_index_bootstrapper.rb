module CustomIndexBootstrapper
  module ControllerClassMethods

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


  module ModelClassMethods
    
    def has_custom_index
      send(:include, ModelInstanceMethods)
    end


  end

  module ModelInstanceMethods

    define_method "index_display_value_for" do |property_name|
      if self.respond_to?("index_display_#{property_name}")
        display_value = self.send("index_display_#{property_name}")
      else
        display_value = self.send(property_name)
      end
      display_value
    end

    define_method "html_table_name" do
      "#{self.class.name.underscore.pluralize}_index_table"
    end

  end

end