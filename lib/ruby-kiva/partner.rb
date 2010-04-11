module Kiva
  class Partner
    include Api
    include DynamicInitializer
    attr_accessor :start_date, :status, :name, :rating, :delinquency_rate, :id, :total_amount_raised, :default_rate, :loans_posted, :countries, :image

    def start_date=(value)
      @start_date = Time.parse(value)
    end

    def image=(value)
      @image = Image.new(value)
    end

    def countries=(value)
      @countries= value.map() {|item| Country.new(item)}
    end

    # Find a partner
    # either by :id or all of them
    # Since kiva does not offer pagination or search,
    # finding by id is implemented in memory/ruby.
    # Items are cached but can be reloaded by passing :reload => true (caching is suggested by kiva...)
    def self.find(params = {})
      if params[:id]
        find().detect() {|item| item.id == params[:id]}
      else
        find_all(params)
      end
    end


    private

    def self.find_all(params)
      if params[:reload] || !@partners
        @partners = json_to_paged_array(get('/partners.json', base_options(params)), 'partners', true)
      end
      @partners
    end
  end
end

#{"start_date"=>"2005-04-15T17:00:00Z",
#{}"rating"=>0,
#{}"status"=>"closed",
#{}"name"=>"East Africa Beta",
#{}"delinquency_rate"=>0,
#{}"id"=>1,
#{}"total_amount_raised"=>26600,
#{}"default_rate"=>9.1917293233083,
#{}"loans_posted"=>62,
#{}"countries"=>[{"name"=>"Uganda", "region"=>"Africa", "iso_code"=>"UG", "location"=>{"geo"=>{"type"=>"point", "level"=>"country", "pairs"=>"2 33"}}}, {"name"=>"Kenya", "region"=>"Africa", "iso_code"=>"KE", "location"=>{"geo"=>{"type"=>"point", "level"=>"country", "pairs"=>"1 38"}}}, {"name"=>"Tanzania", "region"=>"Africa", "iso_code"=>"TZ", "location"=>{"geo"=>{"type"=>"point", "level"=>"country", "pairs"=>"-6 35"}}}],
#{}"image"=>{"template_id"=>1, "id"=>58088}}