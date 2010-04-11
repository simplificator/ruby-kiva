require '../helper'
class PaymentTest < Test::Unit::TestCase
  DATA = {"amount"=> 366.67, "due_date"=>"2011-04-01T07:00:00Z"}

  context 'a new payment' do
    setup do
      @payment = Payment.new()
    end
    should 'have nil amount and due_date' do
      assert !@payment.amount
      assert !@payment.due_date
    end
  end

  context 'a new payment with data' do
    setup do
      @payment = Payment.new(DATA)
    end
    should 'have an amount of 366.67' do
      assert_equal 366.67, @payment.amount
    end

    should 'have a due date' do
      assert_equal Time.parse('2011-04-01T07:00:00Z'), @payment.due_date
    end
  end

end