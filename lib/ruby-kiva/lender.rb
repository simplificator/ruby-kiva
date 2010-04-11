module Kiva
  class Lender
    include Api
    include DynamicInitializer
    attr_accessor :loan_count, :occupation, :country_code, :name, :loan_because,
                  :lender_id, :uid, :whereabouts, :image, :member_since, :invitee_count,
                  :occupational_info, :personal_url, :team_join_date


    def member_since=(value)
      @member_since = Time.parse(value)
    end

    def team_join_date=(value)
      @team_join_date = Time.parse(value)
    end

    def image=(value)
      @image = Image.new(value)
    end

    def lender_page_url
      "http://www.kiva.org/lender/#{self.lender_id}"
    end

    # find the loans for this lender
    # loans are cached to avoid roundtrips, refetch the lender if you need to refresh loans
    def loans(params = {})
      @loans ||= Loan.find(params.merge({:lender_id => self.lender_id}))
    end

    def to_s()
      "<Lender #{self.lender_id}>"
    end

    # Find Lenders
    # __either__
    # :id : A single ID or a comma Separated String of IDs or an Array of IDs
    # __or__
    # :loan_id : A single loan ID
    # __or__
    # :team_id : a single team ID
    #
    # If searching for a single ID, then this method can return nil (no item with this ID found).
    # Otherwise this method will always return a PagedArray instance (which might be empty though)
    # If querying for multiple items, then :page is supported
    def self.find(params)
      if params[:id] # find one or many by lender ID
        data = get("/lenders/#{sanitize_id_parameter(params[:id])}.json", :query => base_options(params))
        many = sanitize_id_parameter(params[:id]).include?(',')
      elsif params[:loan_id] # find lenders for a loan
        data = get("/loans/#{params[:loan_id]}/lenders.json", :query => base_options(params))
        many = true
      elsif params[:team_id]
        data = get("/teams/#{params[:team_id]}/lenders.json", :query => base_options(params))
        many = true
      end
      json_to_paged_array(data, 'lenders', many)
    end
  end
end

# {"loan_count"=>93,
# "occupation"=>"Entrepreneur",
# "country_code"=>"US",
# "name"=>"Matt",
# "loan_because"=>"I love the stories. ",
# "lender_id"=>"matt",
# "invitee_count"=>23,
# "occupational_info"=>"I co-founded a startup nonprofit (this one!) and I work with an amazing group of people dreaming up ways to alleviate poverty through personal lending. ",
# "personal_url"=>"www.socialedge.org/blogs/kiva-chronicles",
# "uid"=>"matt",
# "whereabouts"=>"San Francisco CA",
# "image"=>{"template_id"=>1, "id"=>12829},
# "member_since"=>"2006-01-01T09:01:01Z"}
