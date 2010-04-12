module Kiva
  class JournalEntry
    include DynamicInitializer
    include Api
    attr_accessor :id, :body, :subject, :author, :bulk, :comment_count, :recommendation_count

    typed_attr_accessor :date, Time, :parse
    typed_attr_accessor :image, Kiva::Image
    typed_attr_accessor :video, Kiva::Video

    def bulk?
      self.bulk
    end

    def self.find(params)
      if params[:loan_id]
        json_to_paged_array(get("/loans/#{params[:loan_id]}/journal_entries.json",
          :query => sanitize_options(params)), 'journal_entries', true)
      else
        json_to_paged_array(get("/journal_entries/search.json",
          :query => sanitize_options(params)), 'journal_entries', true)
      end
    end

    def comments(params = {})
      @comments ||= Comment.find(params.merge({:journal_entry_id => self.id}))
    end

    private

    OPTION_MAPPINGS = [
      [:media, :media, false, ['any', 'video', 'image']],
      [:sort_by, :sort_by, false, ['newest', 'oldest', 'recommendation_count', 'comment_count']],
      [:partner_id, :partner, true],
      [:query, :q]
      ]
    def self.sanitize_options(options = {})
      result = base_options(options).merge(map_options(options, OPTION_MAPPINGS))
      result['include_bulk'] = options[:include_bulk] ? 1 : 0
      result
    end

  end
end