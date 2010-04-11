module Kiva
  class Country
    include DynamicInitializer
    attr_accessor :country_code, :name, :region, :iso_code, :location

    def location=(value)
      @location = Location.new(value)
    end
  end
end