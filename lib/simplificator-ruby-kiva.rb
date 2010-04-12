require 'rubygems'
require 'httparty'

%w( dynamic_initializer api payment borrower location country image paged_array video terms loan
   lender partner lending_action journal_entry comment team).each do |name|
  require File.join(File.dirname(__FILE__), 'ruby-kiva', name)
end


include Kiva
#puts JournalEntry.find(:query => 'Food', :partner_id => [78, 100]).inspect
#puts Lender.find(:team_id => 1, :sort_by => 'oldest').inspect
#Loan.find(:query => 'Chincilla')
#puts JournalEntry.find(:query => 'Food', :sort_by => 'oldest').inspect
#puts Loan.find(:query => 'free', :status => 'fundraising', :country_code => 'ug', :partner_id => 84).inspect
#puts Lender.newest.inspect
puts Loan.find(:id => 42940).loan_updates.inspect
#puts Lender.find(:occupation => '').inspect

#puts Lender.find(:id => ['123', 'evan3520']).inspect
#
#puts Lender