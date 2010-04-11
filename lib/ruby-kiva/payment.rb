module Kiva
  class Payment
    include DynamicInitializer
    attr_accessor :amount, :due_date

    def due_date=(value)
      @due_date = Time.parse(value)
    end


    def to_s
      "<Payment due at #{self.due_date} : #{self.amount}>"
    end
  end
end