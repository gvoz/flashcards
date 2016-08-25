# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "nokogiri"
require "open-uri"

def parsing_table(table)
  table.xpath("//tr[position()>1]").each do |row|
    original = row.xpath("td[2]").text
    translated = row.xpath("td[3]").text
    Card.create( original_text: original, translated_text: translated, review_date: 3.days.from_now )
  end
end

page = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words"))

parsing_table(page)

links = page.xpath("//a").select{|link| link.text.include?("Most common German words") }
links.each{|link| parsing_table(Nokogiri::HTML(open("http://www.languagedaily.com" + link['href']))) }
