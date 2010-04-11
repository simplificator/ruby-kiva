module Kiva
  class Country
    include DynamicInitializer
    attr_accessor :country_code, :name, :region, :iso_code

    typed_attr_accessor :location, Kiva::Location
  end
end