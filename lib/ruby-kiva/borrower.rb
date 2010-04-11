module Kiva
  class Borrower
    include DynamicInitializer

    attr_accessor :gender, :pictured, :first_name, :last_name


    def male?
      self.gender == 'M'
    end

    def female?
      self.gender == 'F'
    end

    def pictured?
      self.pictured
    end

    def to_s
      "<#{self.first_name} #{self.last_name} #{self.gender} #{self.pictured?}>"
    end

    #[{"gender"=>"M", "pictured"=>true, "first_name"=>"José Manuel", "last_name"=>"Blanco Chinchilla"}]
  end
end