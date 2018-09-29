# frozen_string_literal: true

module BlogPost
  # Categorize posts on creation or update.
  class Categorizer
    include RawTaxonomyListParser
    attr_reader :params

    def initialize(params = {})
      @params = params
    end

    def add_post_categories
      parse_raw_data
    end

    private

    def parse_raw_data
      return [] unless raw_data
      create_id_array(Category, 'name', 'category_id')
    end

    def raw_data
      params[:post][:raw_categories] unless params.empty?
    end
  end
end
