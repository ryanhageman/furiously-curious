# frozen_string_literal: true

module BlogPost
  # Tag posts on creation and update.
  class Tagger
    include RawTaxonomyListParser
    attr_reader :params

    def initialize(params = {})
      @params = params
    end

    def add_post_tags
      parse_raw_data
    end

    private

    def parse_raw_data
      return [] unless raw_data
      create_id_array(Tag, 'name', 'tag_id')
    end

    def raw_data
      params[:post][:raw_tags] unless params.empty?
    end
  end
end
