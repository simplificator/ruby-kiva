module Kiva
  module Api
    def self.app_id=(value)
      @@app_id = value
    end
    def self.app_id
      @@app_id
    end


    module ClassMethods
      private
      def json_to_paged_array(data, data_key, many)
        if many
          if data[data_key]
            PagedArray.new(data[data_key].map { |item| self.new(item)}, data['paging'] || {})
          else
            PagedArray.new([], {})
          end
        else
          if data[data_key]
            self.new(data[data_key].first)
          else
            nil
          end
        end
      end

      def base_options(options = {})
        if Api.app_id
          {:app_id => Api.app_id}.merge(pagination_options(options))
        else
          pagination_options(options)
        end
      end

      def pagination_options(options = {})
        { :page => options[:page] || 1}
      end

      def sanitize_id_parameter(id)
        Array(id).join(',').gsub(/\s/, '')
      end



      def time_attr_accessor(*names)
        names.each do |name|
          define_method("#{name}=") do |value|
            instance_variable_set("@#{name}", Time.parse(value))
          end
          attr_reader(name)
        end
      end

    end

    module InstanceMethods

    end

    def self.included(receiver)
      receiver.instance_eval do
        extend ClassMethods
        include InstanceMethods
        include HTTParty
        base_uri 'http://api.kivaws.org/v1'
      end
    end
  end
end