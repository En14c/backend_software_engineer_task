# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Recipes Seeds
recipes_seeds_file_path = Rails.root.join('db', 'seeds', 'recipes-en.json')
Recipe.load_seed_data(data_file_path: recipes_seeds_file_path)