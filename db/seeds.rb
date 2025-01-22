# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Real historical queens with Unsplash images
real_queens = [
  {
    name: "Cleopatra VII",
    image: URI.open("https://images.unsplash.com/photo-1612195586862-0b3d5b3c7a8a"),
    facts: "Last active ruler of the Ptolemaic Kingdom of Egypt. Fluent in nine languages. Formed political alliances with Julius Caesar and Mark Antony. Died by suicide in 30 BCE."
  },
  {
    name: "Elizabeth I",
    image: URI.open("https://images.unsplash.com/photo-1579783901586-5391ec664a1a"),
    facts: "Queen of England from 1558-1603. Established Protestantism in England. Defeated the Spanish Armada. Never married, known as the 'Virgin Queen'."
  },
  {
    name: "Catherine the Great",
    image: URI.open("https://images.unsplash.com/photo-1612195587047-2c710f444028"),
    facts: "Longest-ruling female leader of Russia (1762-1796). Expanded Russian territory. Modernized Russia's administration. Patron of arts and education."
  },
  {
    name: "Hatshepsut",
    image: URI.open("https://images.unsplash.com/photo-1612195587056-3b5b3e6d5b0a"),
    facts: "Fifth pharaoh of the Eighteenth Dynasty of Egypt. One of Egypt's most successful pharaohs. Organized major trading expeditions. Commissioned impressive building projects."
  }
]

# Generate fictional historical queens using Faker with placeholder images
fictional_queens = 100.times.map do
  {
    name: "Queen #{Faker::Name.female_first_name} #{Faker::Name.last_name}",
    image: URI.open(Faker::LoremFlickr.image(size: "500x500", search_terms: [ 'portrait' ])),
    facts: Faker::Lorem.sentences(number: 3).join('. ') + "."
  }
end

Queen.create!(real_queens + fictional_queens)
