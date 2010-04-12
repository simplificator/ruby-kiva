module Kiva
  module Api
    # set the API id
    def self.app_id=(value)
      @@app_id = value
    end
    # retrieve the API id
    def self.app_id
      @@app_id if defined? @@app_id
    end

    def self.friendly=(value)
      @@friendly = value
    end
    def self.friendly
      @@friendly if defined? @@friendly
    end


    module ClassMethods
      private
      # map options to a new hash
      # options
      # mappings, an Array with up to 4 elements: [:source_key, :destination_key, sanitize (true, false), valid items]
      # if mapping size is 1, then items are just copied over to new hash using same key
      # if mapping size is 2, then items are copied over using :destination_key as the new key
      # if mapping size is 3, then value is sanitized if mappind[2]
      # if mapping size is 4, then value is verified to be included in mapping[3]
      #
      # if the value is nil in the options hash, then it is not copied
      def map_options(options, mappings)
        result = {}
        mappings.each do |mapping|
          if options.has_key?(mapping[0])
            value = options[mapping[0]]
            raise "Invalid value for #{mapping[0]}: #{value}" if mapping[3] && !mapping[3].include?(value)
            result[mapping[1] || mapping[0]] = mapping[2] ? sanitize_id_parameter(value) : value
          end
        end
        result
      end

      # converts JSON to a PagedArray or a single Instance of a ruby-kiva Api class
      # data: the JSON Date
      # data_key, the key under which the date for a item is stored
      # many if true: create an array / if false: create a single instance
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

      # basic options
      # includes App ID if set and adds pagination options if required
      def base_options(options = {})
        result = pagination_options(options)
        result[:app_id] = Api.app_id if Api.app_id
        result
      end

      # builds a new hash with pagination options
      def pagination_options(options = {})
        options[:page] ? {:page => options[:page]} : {}
      end

      # sanitizes ID parameters for use in path of service
      # pass a String or an Array with IDs, returns a comman separated String of IDs, whitespaces removed
      def sanitize_id_parameter(id)
        Array(id).flatten.join(',').gsub(/\s/, '')
      end
    end


    def self.included(receiver)
      receiver.instance_eval do
        extend ClassMethods
        include HTTParty
        base_uri 'http://api.kivaws.org/v1'
      end
    end
  end
end