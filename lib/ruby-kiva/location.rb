module Kiva
  class Location
    include DynamicInitializer
    attr_accessor :country, :geo, :town, :type, :level
    attr_accessor :country_code

    def geo=(value)
      self.type = value['type']
      self.level = value['level']
      self.pairs = value['pairs']
    end

    def pairs=(value)
      @pairs = value.split(' ').map() {|item| item.to_f}
    end

    def pairs
      @pairs.join(' ')
    end


    # if this is a point?, then returns lat else nil
    def lat
      @pairs[0] if self.point?
    end

    # if this is a point?, then returns lat else nil
    def lng
      @pairs[1] if self.point?
    end

    # true if level is 'town'
    def town?
      'town' == self.level
    end
    # true if level is 'country'
    def country?
      'country' == self.level
    end
    # true if level 'exact'
    def exact?
      'exact' == self.level
    end

    # true if type 'point'
    def point?
      'point' == self.type
    end
    # true if type 'line'
    def line?
      'line' == self.type
    end
    # true if type 'box'
    def box?
      'box' == self.type
    end
    # true if type 'polygon'
    def polygon?
      'polygon' == self.type
    end

    def to_s
      "<Location '%s' '%s' %f/%f>" % [self.country, self.town, self.lat || 0, self.lng || 0]
    end

  end
end