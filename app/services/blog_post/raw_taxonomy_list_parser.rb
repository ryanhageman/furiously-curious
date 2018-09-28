# frozen_string_literal: true

module BlogPost
  # Parse strings to create taxonomy for posts
  module RawTaxonomyListParser
    private

    def create_id_array(klass, attribute, identifier)
      get_ids(klass, attribute).map { |id| { "#{identifier}": id } }
    end

    def get_ids(klass, attribute)
      raw_data_array.map do |item|
        klass.where("#{attribute}": item).first_or_create.id
      end
    end

    def raw_data_array
      raw_data.split(',').map(&:strip)
    end
  end
end
