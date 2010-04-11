module Kiva
  class Comment
    include DynamicInitializer
    include Api
    attr_accessor :id, :author, :whereabouts, :body, :date

    def date=(value)
      @date = Time.parse(value)
    end



    def self.find(params)
      if params[:journal_entry_id]
        json_to_paged_array(get("/journal_entries/#{params[:journal_entry_id]}/comments.json", :query => base_options(params)), 'comments', true)
      end
    end
  end
end