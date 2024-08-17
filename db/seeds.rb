# clean slate (optional, only for development purposes)
Author.destroy_all
Book.destroy_all
Publisher.destroy_all

# create given publishers
publisher_paste_magazine = Publisher.find_or_create_by!(name: "Paste Magazine")
publisher_publishers_weekly = Publisher.find_or_create_by!(name: "Publishers Weekly")
publisher_graywolf_express = Publisher.find_or_create_by!(name: "Graywolf Express")
publisher_mcsweenys = Publisher.find_or_create_by!(name: "McSweeney's")

# create given authors
author_joel_hartse = Author.find_or_create_by!(first_name: "Joel", last_name: "Hatse")
author_hannah_p_templer = Author.find_or_create_by!(first_name: "Hannah", last_name: "Templer", middle_name: "P.")
author_marguerite_z_duras = Author.find_or_create_by!(first_name: "Marguerite", last_name: "Duras", middle_name: "Z.")
author_kingsley_amis = Author.find_or_create_by!(first_name: "Kingsley", last_name: "Amis")
author_fannie_peters_flagg = Author.find_or_create_by!(first_name: "Fannie", last_name: "Flagg", middle_name: "Peters")
author_camille_byron_paglia = Author.find_or_create_by!(first_name: "Camille", last_name: "Paglia", middle_name: "Byron")
author_rainer_steel_rilke = Author.find_or_create_by!(first_name: "Rainer", last_name: "Rilke", middle_name: "Steel")

# create given books
Book.find_or_create_by!(title: "American Elf") do |book|
  book.isbn_13 = "9781891830853"
  book.isbn_10 = "1891830856"
  book.price = 1000
  book.year = 2004
  book.edition = "Book 2"
  book.publisher = publisher_paste_magazine
  book.authors = [ author_joel_hartse, author_hannah_p_templer, author_marguerite_z_duras ]
end

Book.find_or_create_by!(title: "Cosmoknights", isbn_13: "9781603094542") do |book|
  book.isbn_10 = "1603094547"
  book.price = 2000
  book.year = 2019
  book.edition = "Book 1"
  book.publisher = publisher_publishers_weekly
  book.authors = [ author_kingsley_amis ]
end

Book.find_or_create_by!(title: "Essex County", isbn_13: "9781603090384") do |book|
  book.isbn_10 = "160309038X"
  book.price = 500
  book.year = 1990
  book.publisher = publisher_graywolf_express
  book.authors = [ author_kingsley_amis ]
end

Book.find_or_create_by!(title: "Hey, Mister (Vol 1)", isbn_13: "9781891830020") do |book|
  book.isbn_10 = "1891830023"
  book.price = 1200
  book.year = 2000
  book.edition = 'After School Special'
  book.publisher = publisher_graywolf_express
  book.authors = [ author_hannah_p_templer, author_fannie_peters_flagg, author_camille_byron_paglia ]
end

Book.find_or_create_by!(title: "The Underwater Welder", isbn_13: "9781603093989") do |book|
  book.isbn_10 = "1603093982"
  book.price = 2000
  book.year = 3000
  book.publisher = publisher_mcsweenys
  book.authors = [ author_rainer_steel_rilke ]
end
