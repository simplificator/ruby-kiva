require '../helper'
class CommentTest < Test::Unit::TestCase
  DATA = {"body"=>"Ana,\r\n\r\nI wish you continued success with your business.  Keep up the great work!\r\n\r\n", "date"=>"2007-11-23T06:31:45Z", "author"=>"Dee", "id"=>29197, "whereabouts"=>"Monroe, WA  USA"}

  context 'a new comment' do
    setup do
      @comment = Comment.new()
    end
    should 'have nil values' do
      assert !@comment.body
      assert !@comment.date
      assert !@comment.author
      assert !@comment.id
      assert !@comment.whereabouts
    end
  end

  context 'a new comment with data' do
    setup do
      @comment = Comment.new(DATA)
    end

    should 'have a body' do
      assert @comment.body
    end

    should 'have a date' do
      assert_equal Time.parse('2007-11-23T06:31:45Z'), @comment.date
    end

    should 'have an author' do
      assert_equal 'Dee', @comment.author
    end

    should 'have an id' do
      assert_equal 29197, @comment.id
    end

    should 'have whereabouts' do
      assert_equal 'Monroe, WA  USA', @comment.whereabouts
    end
  end
end
