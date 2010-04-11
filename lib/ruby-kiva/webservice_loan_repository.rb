module Kiva
  module WebserviceLoanRepository
    module ClassMethods
      def find_by_id(params)

      end
    end

    module InstanceMethods

    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end