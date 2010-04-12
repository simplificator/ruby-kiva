module Kiva
  class Payment
    include DynamicInitializer
    attr_accessor :amount, :local_amount, :rounded_local_amount, :comment, :payment_id
    typed_attr_accessor :due_date, Time, :parse
    typed_attr_accessor :settlement_date, Time, :parse
    typed_attr_accessor :processed_date, Time, :parse

    def to_s
      "<Payment due at #{self.due_date} : #{self.amount}>"
    end
  end
end