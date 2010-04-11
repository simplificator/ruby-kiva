require '../helper'
class CountryTest < Test::Unit::TestCase
  DATA = {"name"=>"Uganda", "region"=>"Africa", "iso_code"=>"UG", "location"=>{"geo"=>{"type"=>"point", "level"=>"country", "pairs"=>"2 33"}}}

  context 'a new country' do
    setup do
      @country = Country.new()
    end
    should 'have nil attributes' do
      assert !@country.name
      assert !@country.region
      assert !@country.iso_code
      assert !@country.location
    end
  end

  context 'a new country with data' do
    setup do
      @country = Country.new(DATA)
    end

    should 'have a code' do
      assert_equal 'UG',@country.iso_code
    end

    should 'have a name' do
      assert_equal 'Uganda', @country.name
    end

    should 'have a region' do
      assert_equal 'Africa', @country.region
    end

    should 'have a location' do
      assert @country.location
    end
  end

end