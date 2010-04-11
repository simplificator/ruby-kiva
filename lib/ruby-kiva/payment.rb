module Kiva
  class Payment
    include DynamicInitializer
    attr_accessor :amount
    typed_attr_accessor :due_date, Time, :parse

    def to_s
      "<Payment due at #{self.due_date} : #{self.amount}>"
    end
  end
end