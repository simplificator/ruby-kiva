module Kiva
  class Image
    include DynamicInitializer
    attr_accessor :template_id, :id

    def to_s
      "<Image #{self.template_id} / #{self.id}>"
    end

    # Build the URL for this Image.
    # Valid sizes are:
    # * w80h80
    # * w200h200
    # * w325h250
    # * w450h360
    # * fullsize
    def url(size = :w80h80)
      "http://www.kiva.org/img/#{size}/#{self.id}.jpg"
    end
  end
end