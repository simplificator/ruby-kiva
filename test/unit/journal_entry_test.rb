require '../helper'
class JournalEntryTest < Test::Unit::TestCase
  DATA = {"id" => 46861, "subject" => "Loan Refunded","body" => "This loan has been refunded for the following reason: \n\nDue to an administrative error, the loan amount posted was incorrect.  We apologize for any inconvenience.\n","date" => "2008-04-01T19:47:28Z","author" => "Daniel Kahn","bulk" => true,"comment_count" => 0,"recommendation_count" =>0}

  context 'a new journal entry' do
    setup do
      @journal_entry = JournalEntry.new()
    end
    should 'have nil attributes' do
      assert !@journal_entry.id
      assert !@journal_entry.subject
      assert !@journal_entry.body
      assert !@journal_entry.date
      assert !@journal_entry.author
      assert !@journal_entry.bulk
      assert !@journal_entry.comment_count
      assert !@journal_entry.recommendation_count
    end
  end

  context 'a new Journal Entry with data' do
    setup do
      @journal_entry = JournalEntry.new(DATA)
    end

    should 'have an ID' do
      assert_equal 46861, @journal_entry.id
    end

    should 'have a subject' do
      assert_equal 'Loan Refunded', @journal_entry.subject
    end

    should 'have a body' do
      assert @journal_entry.body
    end

    should 'be bulk' do
      assert @journal_entry.bulk?
    end

    should 'have a date' do
      assert_equal Time.parse('2008-04-01T19:47:28Z'), @journal_entry.date
    end

    should 'have an author' do
      assert_equal 'Daniel Kahn', @journal_entry.author
    end

    should 'have recommendation count of 0' do
      assert_equal 0, @journal_entry.recommendation_count
    end

    should 'have a comment count of 0' do
      assert_equal 0, @journal_entry.comment_count
    end

  end

end