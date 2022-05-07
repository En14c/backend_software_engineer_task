task :elasticsearch_create_index => [ :environment ] do
    Recipe.__elasticsearch__.create_index!
    Recipe.import
end