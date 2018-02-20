module CustomIndexBootstrapper
  module ControllerClassMethods

    def has_custom_index(config=[])
      send(:include, InstanceMethods)
      @index_headers = config[:default_headers]
      before_action :set_default_headers, :only => [:index] + config.fetch(:additional_before_actions, [])
    end

    module InstanceMethods
      define_method "define_translation_base" do
        @translation_base = 'invoicezzz'
      end

      def set_default_headers
        resource_class = params[:controller].classify.constantize
        @default_headers = resource_class.new.default_fields_for_index
        @translation_base = resource_class.new.translation_base
      end
    end

  end


  module ModelClassMethods
    
    def has_custom_index(config)
      class_eval do
        send(:include, ModelInstanceMethods)
      end
      define_method "available_fields_for_index" do
        config.fetch(:available_headers, [])
      end

      define_method "required_fields_for_index" do
        config.fetch(:required_headers, [])
      end

      define_method "default_fields_for_index" do |type=nil|
        
        default_headers = config.fetch(:default_headers, [])
        if type.present?
          default_headers = config.fetch(:default_headers, {}).fetch(type.to_sym, default_headers)
        end
        default_headers
      end

      @translation_base = config.fetch(:translation_base, nil)
      define_method "translation_base" do
        @translation_base ||= self.class.name.downcase
      end
    end


  end

  module ModelInstanceMethods
    class_eval do

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

end