module Kiva
  class Terms
    include DynamicInitializer

    attr_accessor :disbursal_amount, :loss_liability, :loan_amount, :disbursal_currency

    typed_attr_accessor :disbursal_date, Time, :parse
    typed_attr_accessor :scheduled_payments, Kiva::Payment, :new, true
    typed_attr_accessor :local_payments, Kiva::Payment, :new, true

  end
end

# {"disbursal_date"=>"2010-02-12T08:00:00Z",
# "scheduled_payments"=>[{"amount"=>"366.67", "due_date"=>"2011-04-01T07:00:00Z"}, {"amount"=>"366.66", "due_date"=>"2012-04-01T07:00:00Z"}, {"amount"=>"366.67", "due_date"=>"2013-04-01T07:00:00Z"}],
# "disbursal_amount"=>600000,
# "local_payments"=>[{"amount"=>200000, "due_date"=>"2011-02-12T08:00:00Z"}, {"amount"=>200000, "due_date"=>"2012-02-12T08:00:00Z"}, {"amount"=>200000, "due_date"=>"2013-02-12T08:00:00Z"}],
# "loss_liability"=>{"currency_exchange_coverage_rate"=>0.2, "nonpayment"=>"lender", "currency_exchange"=>"shared"},
# "loan_amount"=>1100,
# "disbursal_currency"=>"CRC"}