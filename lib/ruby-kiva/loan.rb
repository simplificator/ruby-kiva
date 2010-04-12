module Kiva
  class Loan
    include Api
    include DynamicInitializer

    attr_accessor :name, :activity, :use, :borrower_count,
                  :status, :id, :partner_id, :description,
                  :loan_amount, :funded_amount, :paid_amount, :basket_amount, :sector,
                  :delinquent, :journal_totals, :terms, :funded_date

    typed_attr_accessor :location, Kiva::Location
    typed_attr_accessor :image, Kiva::Image
    typed_attr_accessor :video, Kiva::Video
    typed_attr_accessor :terms, Kiva::Terms
    typed_attr_accessor :posted_date, Date, :parse
    typed_attr_accessor :paid_date, Date, :parse
    typed_attr_accessor :borrowers, Kiva::Borrower, :new, true
    typed_attr_accessor :payments, Kiva::Payment, :new, true

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

    # Get the lenders for this loan
    # Caches the lenders, reload loan if you need to refresh the lenders
    def lenders(params = {})
      @lenders ||= Lender.find(params.merge({:loan_id => self.id}))
    end


    def journal_entries(params = {})
      @journal_entries ||= JournalEntry.find(params.merge({:loan_id => self.id}))
    end

    def loan_updates
      @loan_updates ||= find_loan_updates()
    end


    # Supported options:
    # * :page: The requested page number
    def self.newest(options = {})
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
        data = get("/loans/#{sanitize_id_parameter(params[:id])}.json", :query => sanitize_options(params))
        many = sanitize_id_parameter(params[:id]).include?(',')
      elsif params[:lender_id] # find all loans for a lender
        data = get("/lenders/#{params[:lender_id]}/loans.json", :query => sanitize_options(params))
        many = true
      elsif params[:team_id] # find all loans for a team
        data = get("/teams/#{params[:team_id]}/loans.json", :query => sanitize_options(params))
        many = true
      else # search
        puts "Searching with #{base_options(params).merge(find_options(params)).inspect}"
        data = get('/loans/search.json', :query => sanitize_options(params))
        many = true
      end
      json_to_paged_array(data, 'loans', many)
    end

    def to_s()
      "<Loan '%s' (%s) in %s with status %s, from %s>" % [self.name, self.id, self.location, self.id, self.borrowers]
    end

    private

    def find_loan_updates
      data = Loan.get("/loans/#{self.id}/updates.json")
      data['loan_updates'].map do |entry|
        type = entry.delete('update_type')
        case type
        when 'journal_entry' then JournalEntry.new(entry['journal_entry'])
        when 'payment' then Payment.new(entry['payment'])
        else raise "unknown type #{type}"
        end
      end
    end

    OPTION_MAPPINGS = [
      [:partner_id, :partner, true],
      [:sort_by, :sort_by, false, ['oldest', 'newest']],
      [:status, :status, false, ['fundraising', 'funded', 'in_repayment', 'paid', 'defaulted']],
      [:query, :q],
      [:gender, :gender, false, ['male', 'female']],
      [:region, :region, false, ['na', 'ca', 'sa', 'af', 'as', 'me', 'ee']],
      [:sector],
      [:country_code],
    ]
    def self.sanitize_options(options = {})
      base_options(options).merge(map_options(options, OPTION_MAPPINGS))
    end


  end
end