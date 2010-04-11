require '../helper'
class BorrowerTest < Test::Unit::TestCase
  DATA = {"gender"=>"M", "pictured"=>true, "first_name"=>"José Manuel", "last_name"=>"Blanco Chinchilla"}

  context 'a new borrower' do
    setup do
      @borrower = Borrower.new()
    end
    should 'have nil amount and due_date' do
      assert !@borrower.gender
      assert !@borrower.pictured
      assert !@borrower.first_name
      assert !@borrower.last_name
    end

    should 'neither be male nor female' do
      assert !@borrower.male?
      assert !@borrower.female?
    end

    should 'not be pictured?' do
      assert !@borrower.pictured?
    end

  end

  context 'a new borrower with data' do
    setup do
      @borrower = Borrower.new(DATA)
    end

    should 'be pictured?' do
      assert @borrower.pictured?
    end

    should 'be male' do
      assert @borrower.male?
    end

    should 'have a first name' do
      assert_equal 'José Manuel', @borrower.first_name
    end

    should 'have a last name' do
      assert_equal 'Blanco Chinchilla', @borrower.last_name
    end

  end

end