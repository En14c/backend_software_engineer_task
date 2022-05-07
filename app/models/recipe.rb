class Recipe < ApplicationRecord
  ES_INDEXED_FIELDS = [:ingredients].freeze

  extend Pagy::ElasticsearchRails
  include Searchable

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :ingredients, type: :text, analyzer: 'english'
    end
  end

  belongs_to :category
  belongs_to :author

  def as_indexed_json(options = nil)
    as_json(only: [:ingredients])
  end

  def self.search(es_query, search_with:, from:, size:, **kwargs)
    __elasticsearch__.search({
      from: from,
      size: size,
      query: {
        multi_match: {
          query: es_query,
          fields: search_with & ES_INDEXED_FIELDS,
          operator: "OR"
        }
      }
    })
  end

  def self.load_seed_data(data_file_path:)
    begin
      recipes_seeds = JSON.parse(File.read(data_file_path), symbolize_names: true)
    rescue
      Rails.logger.error("Failed to read receipes seed data file: #{data_file_path}")
      return
    end

    recipes_seeds.each do |recipe_seed|
      begin
        author = Author.find_or_create_by(username: recipe_seed[:author])
        category = Category.find_or_create_by(name: recipe_seed[:category])
        recipe = create(title: recipe_seed[:title], cook_time: recipe_seed[:cook_time],
                        prep_time: recipe_seed[:prep_time], ingredients: recipe_seed[:ingredients].join(','),
                        ratings: recipe_seed[:ratings], cuisine: recipe_seed[:cuisine],
                        author: author, category: category, image: recipe_seed[:image])
        Rails.logger.info("Inserted recipe seed: #{recipe}")
      rescue
        Rails.logger.warn("Failed to insert recipe seed: #{recipe_seed}")
      end
    end
  end
end
