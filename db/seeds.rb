# clean slate (optional, only for development purposes)
Author.destroy_all
Book.destroy_all
Publisher.destroy_all

# create given publishers
publisher_paste_magazine = Publisher.find_or_create_by!(name: "Paste Magazine")
publisher_publishers_weekly = Publisher.find_or_create_by!(name: "Publishers Weekly")
publisher_graywolf_express = Publisher.find_or_create_by!(name: "Graywolf Express")
publisher_mcsweenys = Publisher.find_or_create_by!(name: "McSweeney's")
publisher_outskirts = Publisher.find_or_create_by!(name: "Outskirts Press")
publisher_white_rose  = Publisher.find_or_create_by!(name: "White Rose Publishing")

# create given authors
author_michael_mcclure  = Author.find_or_create_by!(first_name: "Michael", last_name: "McClure")
author_joel_hartse = Author.find_or_create_by!(first_name: "Joel", last_name: "Hatse")
author_hannah_p_templer = Author.find_or_create_by!(first_name: "Hannah", last_name: "Templer", middle_name: "P.")
author_marguerite_z_duras = Author.find_or_create_by!(first_name: "Marguerite", last_name: "Duras", middle_name: "Z.")
author_kingsley_amis = Author.find_or_create_by!(first_name: "Kingsley", last_name: "Amis")
author_fannie_peters_flagg = Author.find_or_create_by!(first_name: "Fannie", last_name: "Flagg", middle_name: "Peters")
author_camille_byron_paglia = Author.find_or_create_by!(first_name: "Camille", last_name: "Paglia", middle_name: "Byron")
author_rainer_steel_rilke = Author.find_or_create_by!(first_name: "Rainer", last_name: "Rilke", middle_name: "Steel")
author_list_lickel = Author.find_or_create_by!(first_name: "Lisa", last_name: "Lickel", middle_name: "J")

# create given books
Book.find_or_create_by!(title: "American Elf") do |book|
  book.isbn_13 = "9781891830853"
  book.isbn_10 = "1891830856"
  book.price = 1000
  book.year = 2004
  book.image = 'american_elf'
  book.edition = "Book 2"
  book.publisher = publisher_paste_magazine
  book.authors = [ author_joel_hartse, author_hannah_p_templer, author_marguerite_z_duras ]
end

Book.find_or_create_by!(title: "Cosmoknights", isbn_13: "9781603094542") do |book|
  book.isbn_10 = "1603094547"
  book.price = 2000
  book.year = 2019
  book.image = 'cosmo_nights'
  book.edition = "Book 1"
  book.publisher = publisher_publishers_weekly
  book.authors = [ author_kingsley_amis ]
end

Book.find_or_create_by!(title: "Essex County", isbn_13: "9781603090384") do |book|
  book.isbn_10 = "160309038X"
  book.price = 500
  book.year = 1990
  book.image = 'essex_county'
  book.publisher = publisher_graywolf_express
  book.authors = [ author_kingsley_amis ]
end

Book.find_or_create_by!(title: "Hey, Mister (Vol 1)", isbn_13: "9781891830020") do |book|
  book.isbn_10 = "1891830023"
  book.price = 1200
  book.year = 2000
  book.image = 'hey_mister'
  book.edition = 'After School Special'
  book.publisher = publisher_graywolf_express
  book.authors = [ author_hannah_p_templer, author_fannie_peters_flagg, author_camille_byron_paglia ]
end

Book.find_or_create_by!(title: "The Underwater Welder", isbn_13: "9781603093989") do |book|
  book.isbn_10 = "1603093982"
  book.price = 2000
  book.year = 3000
  book.image = 'under_water_welder'
  book.publisher = publisher_mcsweenys
  book.authors = [ author_rainer_steel_rilke ]
end

Book.find_or_create_by!(title: "The Bend of Luck", isbn_13: "9781603095099") do |book|
  book.isbn_10 = "1603095098"
  book.price = 2000
  book.year = 2009
  book.image = 'bend_of_luck'
  book.publisher = publisher_outskirts
  book.authors = [ author_michael_mcclure ]
end

Book.find_or_create_by!(title: "Doughnuts and Doom", isbn_13: "9781649360809") do |book|
  book.isbn_10 = "1649360800"
  book.price = 2000
  book.year = 2011
  book.image = 'doughnuts_and_doom'
  book.publisher = publisher_white_rose
  book.authors = [ author_list_lickel ]
end
