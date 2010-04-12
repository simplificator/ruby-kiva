module Kiva
  class Team

    include DynamicInitializer
    include Api

    attr_accessor :id, :shortname, :name, :category, :image, :whereabouts, :loan_because, :description,
                  :website_url, :membership_type, :member_count, :loan_count, :loaned_amount

    typed_attr_accessor :team_since, Time, :parse
    typed_attr_accessor :image, Kiva::Image

    def lenders(params = {})
      @lenders ||= Lender.find(params.merge({:team_id => self.id}))
    end
    def loans(params = {})
      @loans ||= Loan.find(params.merge({:team_id => self.id}))
    end

    # find a team by :id or :shortname
    def self.find(params)
      if params[:id]
        data = get("/teams/#{sanitize_id_parameter(params[:id])}.json", :query => sanitize_options(params))
        many = sanitize_id_parameter(params[:id]).include?(',')
      elsif params[:shortname]
        data = get("/teams/using_shortname/#{sanitize_id_parameter(params[:shortname])}.json", :query => sanitize_options(params))
        many = sanitize_id_parameter(params[:shortnames]).include?(',')
      else
        data = get("/teams/search.json", :query => sanitize_options(params))
        many = true
      end
      json_to_paged_array(data, 'teams', many)
    end

    private

    OPTION_MAPPINGS = [
      [:sort_by, :sort_by, false, ['oldest', 'newest']],
      [:occupation],
      [:query, :q],
      [:country_code],
      [:membership_type, :membership_type, false, ['open', 'closed']],
      [:category, :category, false, ['Alumni Groups', 'Businesses', 'Businesses - Internal Groups', 'Clubs', 'Colleges/Universities', 'Common Interest', 'Events', 'Families', 'Field Partner Fans', 'Friends', 'Local Area', 'Memorials', 'Religious Congregations', 'Schools', 'Sports Groups', 'Youth Groups', 'Other']],
    ]
    def self.sanitize_options(options = {})
      base_options(options).merge(map_options(options, OPTION_MAPPINGS))
    end

  end
end