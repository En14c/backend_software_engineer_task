module Searchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
      index_name [Rails.application.class.module_parent_name.underscore, self.name.downcase].join('_')
    end
end