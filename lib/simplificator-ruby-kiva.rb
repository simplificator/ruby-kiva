require 'rubygems'
require 'httparty'

%w( dynamic_initializer api payment borrower location country image paged_array video terms loan
   lender partner lending_action journal_entry comment team).each do |name|
  require File.join(File.dirname(__FILE__), 'ruby-kiva', name)
end
