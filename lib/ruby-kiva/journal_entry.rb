module Kiva
  class JournalEntry
    include DynamicInitializer
    include Api
    attr_accessor :id, :body, :subject, :author, :bulk, :comment_count, :recommendation_count

    typed_attr_accessor :date, Time, :parse

    def bulk?
      self.bulk
    end

    def self.find(params)
      if params[:loan_id]
        json_to_paged_array(get("/loans/#{params[:loan_id]}/journal_entries.json",
          :query => base_options.merge(find_options(params))), 'journal_entries', true)
      end
    end

    def comments(params = {})
      @comments ||= Comment.find(params.merge({:journal_entry_id => self.id}))
    end

    private

    def self.find_options(options)
      result = {}
      result['include_bulk'] = options[:include_bulk] ? 1 : 0
      result
    end
  end
end