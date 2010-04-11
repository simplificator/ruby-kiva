module Kiva
  module DynamicInitializer
    module ClassMethods
    end

    module InstanceMethods
      def initialize(options = {})
        options.each do |key, value|
          self.send("#{key}=", value)
        end
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end