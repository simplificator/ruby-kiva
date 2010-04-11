module Kiva
  module FilesystemLoanRepository
    module ClassMethods
      def find_by_id
      end


      def base_dir
        '/tmp/kiva'
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