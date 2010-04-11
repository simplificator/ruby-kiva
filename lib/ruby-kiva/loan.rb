module Kiva
  class Loan
    include Api
    include DynamicInitializer

    attr_accessor :name, :activity, :location, :use, :borrower_count,
                  :status, :posted_date, :id, :partner_id, :description,
                  :loan_amount, :funded_amount, :paid_amount, :basket_amount, :sector, :image,
                  :delinquent, :journal_totals, :borrowers, :terms, :funded_date, :video

    typed_attr_accessor :location, Kiva::Location
    typed_attr_accessor :image, Kiva::Image
    typed_attr_accessor :video, Kiva::Video
    typed_attr_accessor :terms, Kiva::Terms
    typed_attr_accessor :posted_date, Date, :parse

    #def location=(value)
    #  @location =  Location.new(value)
    #end

    #def image=(value)
    #  @image = Image.new(value)
    #end

    #def video=(value)
    #  @video = Video.new(value)
    #end
    def borrowers=(value)
      @borrowers = value.map() {|item| Borrower.new(item) }
    end

    #def terms=(value)
    #  @terms = Terms.new(value)
    #end

    # description consists of available languages and texts in different languages
    # texts are only available when doing a find by id
    def description=(value)
      @description = value
      @description_languages = value['languages']
      @description_texts = value['texts']
    end

    def description_languages
      @description_languages
    end

    def description_texts
      @description_texts
    end

    def description_text(language)
      description_texts[language]
    end

    #def posted_date=(value)
    #  # 2009-01-09T09:50:08Z
    #  @posted_date = Time.parse(value)
    #end

    # Get the lenders for this loan
    # Caches the lenders, reload loan if you need to refresh the lenders
    def lenders(params = {})
      @lenders ||= Lender.find(params.merge({:loan_id => self.id}))
    end


    def journal_entries(params = {})
      @journal_entries ||= JournalEntry.find(params.merge({:loan_id => self.id}))
    end


    # Supported options:
    # * :page: The requested page number
    def self.recent(options = {})
      data = get('/loans/newest.json', :query => base_options(options))
      json_to_paged_array(data, 'loans', true)
    end

    # Search for Loans.
    # Different searches are possible
    # __either:__
    # :id: An ID, a comma delimited String of IDs or an Array of IDs
    # __or__
    # :lender_id: A single ID of a lender
    # __or__
    # :team_id : a single ID of a team
    # __or a combination of__
    # * :partner_id: A (comma delimited) String of Partner IDs or an Array of partner IDs
    # * :status: A String or symbol with the Loan status
    # * :query: A String
    #
    # If searching for a single ID, then this method can return nil (no item with this ID found).
    # Otherwise this method will always return a PagedArray instance (which might be empty though)
    #
    # When searching for multiple Loans, then the :page parameter is supported to specify the desired page.
    def self.find(params)
      if params[:id] # find one or many by ID
        data = get("/loans/#{sanitize_id_parameter(params[:id])}.json", :query => base_options(params))
        many = sanitize_id_parameter(params[:id]).include?(',')
      elsif params[:lender_id] # find all loans for a lender
        data = get("/lenders/#{params[:lender_id]}/loans.json", :query => base_options(params))
        many = true
      elsif params[:team_id] # find all loans for a team
        data = get("/teams/#{params[:team_id]}/loans.json", :query => base_options(params))
        many = true
      else # search
        data = get('/loans/search.json', :query => base_options(params).merge(find_options(params)))
        many = true
      end
      json_to_paged_array(data, 'loans', many)
    end

    def to_s()
      "<Loan '%s' (%s) in %s with status %s, from %s>" % [self.name, self.id, self.location, self.status, self.borrowers]
    end

    private

    def self.find_options(options = {})
      result = {}
      if options[:partner_id]
        result[:partner] = sanitize_id_parameter(options[:partner_id])
      end
      result[:status] = options[:status] if options[:status]
      result[:q] = options[:query] if options[:query]
      result
    end


  end
end