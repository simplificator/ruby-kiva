module Kiva
  # Adds pagination information to array
  # Pagination attributes/methods have the same names as the wonderful will_paginate
  class PagedArray < Array
    attr_reader :current_page, :per_page, :total_entries, :total_pages

    def initialize(data, options = {})
      super data
      @current_page = options['page'] || 1
      @per_page = options['page_size'] || data.size
      @total_pages = options['pages'] || 1
      @total_entries = options['total'] || data.size
    end

    def offset
      (self.current_page - 1) * self.per_page
    end

    def next_page?()
      self.current_page < self.total_pages
    end

    def next_page
      self.current_page + 1 if next_page?
    end

    def previous_page
      self.current_page - 1 if previous_page?
    end

    def previous_page?()
      self.current_page > 1
    end

    def from_entry
      self.offset + 1 unless self.out_of_bounds?
    end

    def out_of_bounds?
      self.current_page < 1 || self.current_page > self.total_pages
    end

    def to_entry
      [self.offset + self.per_page, self.total_entries].min unless self.out_of_bounds?
    end

    def inspect
      "#{pagination_info}\n#{super}"
    end

    def to_s
      self.inspect
    end

    private


    def pagination_info
      if out_of_bounds?
        "<Page is out of bounds>"
      else
        "<Page #{self.current_page} of #{self.total_pages} (entries #{self.from_entry} - #{self.to_entry} of #{self.total_entries}). Previous? #{self.previous_page?}, Next? #{self.next_page?}>"
      end
    end
  end
end