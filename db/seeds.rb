# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

Cocktail.destroy_all
Ingredient.destroy_all

ingredients_url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_json = open(ingredients_url).read
ingredients = JSON.parse(ingredients_json)

ingredients_array = ingredients["drinks"]

ingredients_array.each do |ingredient|
  Ingredient.create!(name: ingredient["strIngredient1"])
end

cocktails_url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Gin'
cocktails_json = open(cocktails_url).read
cocktails = JSON.parse(cocktails_json)

cocktails_array = cocktails["drinks"]

photo_url = "https://picsum.photos/200/300?grayscale"
cocktails_array.each do |cocktail|
  new_cocktail = Cocktail.new(name: cocktail["strDrink"])
  new_cocktail.remote_photo_url = photo_url
  new_cocktail.save
end
