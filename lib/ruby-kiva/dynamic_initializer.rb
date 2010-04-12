module Kiva
  module DynamicInitializer
    module ClassMethods
      def typed_attr_accessor(name, klass, factory_method = :new, array = false)
         define_method("#{name}=") do |value|
          if array
            typed = value.map() {|item| klass.send(factory_method, item)}
          else
            typed = klass.send(factory_method, value)
          end
          instance_variable_set("@#{name}", typed)
        end
        attr_reader name
      end
    end

    module InstanceMethods
      def initialize(options = {})
        options.each do |key, value|
          if respond_to?("#{key}=")
            self.send("#{key}=", value)
          elsif !Api.friendly
            raise "Attribute #{key} is not yet supported. Set Api.friendly = true"
          end
        end
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end