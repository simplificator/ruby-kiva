module Kiva
  class LendingAction
    include Api
    include DynamicInitializer

    attr_accessor :date, :id, :lender, :loan, :sector, :basket_amount
    def self.recent(options = {})
      json_to_paged_array(get('/lending_actions/recent.json'), 'lending_actions', true)
    end


    def date=(value)
      @date = Time.parse(value)
    end

    def lender=(value)
      @lender = Lender.new(value)
    end

    def loan=(value)
      @loan = Loan.new(value)
    end
  end
end

#{"date"=>"2010-04-09T22:00:27Z",
#{}"id"=>33614166,
#{}"lender"=>{"country_code"=>"US", "name"=>"Eisakouo Partnership", "lender_id"=>"eisakouopartnership3932", "uid"=>"eisakouopartnership3932", "whereabouts"=>"Columbia PA", "image"=>{"template_id"=>1, "id"=>482823}},
#{}"loan"=>{"borrower_count"=>1, "status"=>"fundraising", "name"=>"Laoy Lok", "posted_date"=>"2010-04-07T06:40:02Z", "activity"=>"Cattle", "id"=>191433, "description"=>{"languages"=>["en"]}, "partner_id"=>109, "use"=>"To buy a cow for breeding", "loan_amount"=>300, "funded_amount"=>0, "image"=>{"template_id"=>1, "id"=>520519}, "location"=>{"country_code"=>"KH", "country"=>"Cambodia", "geo"=>{"type"=>"point", "level"=>"country", "pairs"=>"13 105"}, "town"=>"Rung Village"},
#{}"sector"=>"Agriculture",
#{}"basket_amount"=>0}}