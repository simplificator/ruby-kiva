module Kiva
  class JournalEntry
    MEDIA_TYPES = ['any', 'video', 'image']
    SORT_BY = ['newest', 'oldest', 'recommendation_count', 'comment_count']
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
          :query => base_options.merge(find_options(params))), 'journal_entries', true)
      else
        json_to_paged_array(get("/journal_entries/search.json",
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
      if options[:media]
        raise "Unknown media type #{options[:media]}" unless MEDIA_TYPES.include?(options[:media].to_s)
        result[:media] = options[:media]
      end
      if options[:sort_by]
        raise "Unknown sort_by #{options[:sort_by]}" unless SORT_BY.include?(options[:sort_by].to_s)
        result[:sort_by] = options[:sort_by]
      end
      result[:partner] = sanitize_id_parameter(options[:partner_id]) if options[:partner_id]
      result[:q] = options[:query] if options[:query]

      result
    end
  end
end