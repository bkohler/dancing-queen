# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Historical queens
historical_queens = [
  {
    name: "Cleopatra VII",
    facts: "Last active ruler of the Ptolemaic Kingdom of Egypt. Fluent in nine languages. Formed political alliances with Julius Caesar and Mark Antony. Died by suicide in 30 BCE."
  },
  {
    name: "Elizabeth I",
    facts: "Queen of England from 1558-1603. Established Protestantism in England. Defeated the Spanish Armada. Never married, known as the 'Virgin Queen'."
  },
  {
    name: "Catherine the Great",
    facts: "Longest-ruling female leader of Russia (1762-1796). Expanded Russian territory. Modernized Russia's administration. Patron of arts and education."
  },
  {
    name: "Hatshepsut",
    facts: "Fifth pharaoh of the Eighteenth Dynasty of Egypt. One of Egypt's most successful pharaohs. Organized major trading expeditions. Commissioned impressive building projects."
  }
]

# Generate 100 fictional historical queens using Faker
100.times do
  historical_queens << {
    name: "Queen #{Faker::Name.female_first_name} #{Faker::Name.last_name}",
    facts: Faker::Lorem.sentences(number: 3).join('. ') + "."
  }
end

Queen.create!(historical_queens)
