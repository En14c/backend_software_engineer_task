module Api
    module V1
        class RecipesController < ApplicationController
            def index; end

            def search
                @pagy, @recipes = pagy_elasticsearch_rails(Recipe.pagy_search(es_query, search_with: [:ingredients]).records)
            end

            private

            def es_query
                params.require(:es_query)
            end
        end
    end
end