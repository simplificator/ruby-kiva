module Kiva
  class LendingAction
    include Api
    include DynamicInitializer

    attr_accessor :id, :sector, :basket_amount

    typed_attr_accessor :date, Time, :parse
    typed_attr_accessor :lender, Kiva::Lender
    typed_attr_accessor :loan, Kiva::Loan


    def self.newest(options = {})
      json_to_paged_array(get('/lending_actions/recent.json'), 'lending_actions', true)
    end
    # renamed from recent to 'newest' to make it consistent with LendingAction and Lender
    class <<self
      alias_method :recent, :newest
    end

  end
end

#{"date"=>"2010-04-09T22:00:27Z",
#{}"id"=>33614166,
#{}"lender"=>{"country_code"=>"US", "name"=>"Eisakouo Partnership", "lender_id"=>"eisakouopartnership3932", "uid"=>"eisakouopartnership3932", "whereabouts"=>"Columbia PA", "image"=>{"template_id"=>1, "id"=>482823}},
#{}"loan"=>{"borrower_count"=>1, "status"=>"fundraising", "name"=>"Laoy Lok", "posted_date"=>"2010-04-07T06:40:02Z", "activity"=>"Cattle", "id"=>191433, "description"=>{"languages"=>["en"]}, "partner_id"=>109, "use"=>"To buy a cow for breeding", "loan_amount"=>300, "funded_amount"=>0, "image"=>{"template_id"=>1, "id"=>520519}, "location"=>{"country_code"=>"KH", "country"=>"Cambodia", "geo"=>{"type"=>"point", "level"=>"country", "pairs"=>"13 105"}, "town"=>"Rung Village"},
#{}"sector"=>"Agriculture",
#{}"basket_amount"=>0}}