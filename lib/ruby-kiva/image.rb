module Kiva
  class Image
    include DynamicInitializer
    attr_accessor :template_id, :id

    SIZES = %w(w80h80 w200h200 w325h250 w450h360 fullsize)

    def to_s
      "<Image #{self.template_id} / #{self.id}>"
    end

    # Build the URL for this Image.
    # See SIZES for valid sizes, defaults to w80h80
    def url(size = 'w80h80')
      raise 'Must have a template id and an id' unless self.template_id && self.id
      raise "Unknown size #{size}" unless SIZES.include?(size.to_s)
      "http://www.kiva.org/img/#{size}/#{self.id}.jpg"
    end
  end
end