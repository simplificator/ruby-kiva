require 'rubygems'
require 'httparty'

%w( dynamic_initializer api payment borrower location country image paged_array video terms loan
   lender partner lending_action journal_entry comment team).each do |name|
  require File.join(File.dirname(__FILE__), 'ruby-kiva', name)
end

include Kiva
puts "=" * 20

Api.app_id = 'we are creating a ruby wrapper, sorry for buggin your API all the time'
### Loans
## finding Loans by ID

puts Loan.find(:id => 180009)
#puts Loan.find(:id => '180009, 180008').size
#puts Loan.find(:id => [180009, '180008']).size

## finding Loans by lender_id
#puts Loan.find(:lender_id => 'matt', :page => 3).inspect

## finding Loans
#puts Loan.find(:query => 'Chinchilla', :page => 1).inspect
#puts Loan.find(:partner_id => [150, 156, 188, 190, 120], :query => 'Vegetable', :status => :in_repayment, :page => 2).inspect

### Partners

#puts Partner.find().first.inspect
#puts Partner.find(:id => 1).inspect


### Lending Actions
#LendingAction.recent.first


### Journal Entries
#puts JournalEntry.find(:loan_id => 180009, :include_bulk => true, :page => 10).inspect
#puts Loan.find(:id => 180009).journal_entries(:include_bulk => true).first.comments
#puts Comment.find(:journal_entry_id => 28342).inspect


### Team
#puts Team.find(:id => 2).team_since
#puts Team.find(:shortname => 'buildkiva')
#puts Team.find(:id => 6341).lenders(:page => 1).inspect
puts "=" * 20