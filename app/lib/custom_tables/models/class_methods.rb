module CustomTables
  module Models
    module ClassMethods
      
      def has_custom_index
        send(:include, InstanceMethods)
      end

    end

    module InstanceMethods

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