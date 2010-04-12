require '../helper'
class LenderTest < Test::Unit::TestCase
  DATA =  {"loan_count"=>93, "occupation"=>"Entrepreneur", "country_code"=>"US",
   "name"=>"Matt",
   "loan_because"=>"I love the stories. ",
   "lender_id"=>"matt",
   "invitee_count"=>23,
   "occupational_info"=>"I co-founded a startup nonprofit (this one!) and I work with an amazing group of people dreaming up ways to alleviate poverty through personal lending. ",
   "personal_url"=>"www.socialedge.org/blogs/kiva-chronicles",
   "uid"=>"matt",
   "whereabouts"=>"San Francisco CA",
   "image"=>{"template_id"=>1, "id"=>12829},
   "member_since"=>"2006-01-01T09:01:01Z"}

  context 'a new lender' do
    setup do
      @lender = Lender.new()
    end
    should 'have nil attributes' do
      assert !@lender.loan_count
      assert !@lender.occupation
      assert !@lender.country_code
      assert !@lender.name
      assert !@lender.loan_because
      assert !@lender.lender_id
      assert !@lender.invitee_count
      assert !@lender.occupational_info
      assert !@lender.personal_url
      assert !@lender.uid
      assert !@lender.whereabouts
      assert !@lender.image
      assert !@lender.member_since
    end
  end

  context 'a new lender with data' do
    setup do
      @lender = Lender.new(DATA)
    end


    should 'have a name' do
      assert_equal 'Matt', @lender.name
    end
    should 'have reason for the loans' do
      assert_equal 'I love the stories. ', @lender.loan_because
    end

    should 'have a lender_id' do
      assert_equal 'matt', @lender.lender_id
    end

    should 'have an invitee count' do
      assert 23, @lender.invitee_count
    end

    should 'have occupational_info' do
      assert @lender.occupational_info
    end

    should 'have a personal_url' do
      assert @lender.personal_url
    end

    should 'have an uid' do
      assert_equal 'matt', @lender.uid
    end

    should 'have whereabouts' do
      assert_equal 'San Francisco CA', @lender.whereabouts
    end

    should 'have an image' do
      assert @lender.image
    end

    should 'have member_since' do
      assert_equal Time.parse('2006-01-01T09:01:01Z'), @lender.member_since
    end
  end

end