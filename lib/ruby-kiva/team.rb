module Kiva
  class Team
    include DynamicInitializer
    include Api

    attr_accessor :id, :shortname, :name, :category, :image, :whereabouts, :loan_because, :description,
                  :website_url, :membership_type, :member_count, :loan_count, :loaned_amount
    #time_attr_accessor :team_since
    typed_attr_accessor :team_since, Time, :parse
    def image=(value)
      @image = Image.new(value)
    end

    #def team_since=(value)
    #  @team_since = Time.parse(value)
    #end

    def lenders(params = {})
      @lenders ||= Lender.find(params.merge({:team_id => self.id}))
    end
    def loans(params = {})
      @loans ||= Loan.find(params.merge({:team_id => self.id}))
    end
    # find a team by :id or :shortname
    def self.find(params)
      if params[:id]
        json_to_paged_array(get("/teams/#{params[:id]}.json", :query => base_options(params)), 'teams', false)
      elsif params[:shortname]
        json_to_paged_array(get("/teams/using_shortname/#{params[:shortname]}.json", :query => base_options(params)), 'teams', false)
      end
    end
  end
end