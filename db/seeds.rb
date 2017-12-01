# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'


p "clearing DB"
p "starting seeding"

url_cocktails = "http://www.thecocktaildb.com/api/json/v1/1/random.php"
30.times do |x|
  cocktail_list = open(url_cocktails).read
  cocktail_parse = JSON.parse(cocktail_list)
  picture_url = cocktail_parse["drinks"][0]["strDrinkThumb"]
  cocktail = Cocktail.new(name: cocktail_parse["drinks"][0]["strDrink"])
  cocktail.photo_url = picture_url
  (1..15).each do |x|
    unless cocktail_parse["drinks"][0]["strIngredient" + x.to_s].empty?
      # print cocktail_parse["drinks"][0]["strMeasure" + x.to_s] + "OF "+ cocktail_parse["drinks"][0]["strIngredient" + x.to_s]
      # print "\n"

      dose = Dose.new(description: cocktail_parse["drinks"][0]["strMeasure" + x.to_s])
      dose.cocktail = cocktail
      dose.ingredient = Ingredient.find_by(name: cocktail_parse["drinks"][0]["strIngredient" + x.to_s])
      if dose.save
        puts "dose created"
      else
        puts "bug"
      end
    end
  end
  puts cocktail_parse["drinks"][0]["strDrink"] + " saved !!" if cocktail.save!
end
