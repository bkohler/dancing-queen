# Clear existing data
Queen.destroy_all

# Helper method to attach image from URL
def attach_image_from_url(record, url, filename)
  return unless url
  require 'open-uri'
  begin
    file = URI.open(url)
    record.image.attach(io: file, filename: filename)
  rescue OpenURI::HTTPError => e
    puts "Failed to attach image for #{record.name}: #{e.message}"
  end
end

# Create historical queens
queens_data = [
  {
    name: "Cleopatra VII",
    facts: "Last active ruler of the Ptolemaic Kingdom of Egypt",
    reign_start: Date.new(-51, 1, 1),
    reign_end: Date.new(-30, 8, 12),
    kingdom: "Ptolemaic Kingdom of Egypt",
    achievements: "Preserved Egypt's independence as a kingdom, restored Ptolemaic control over Cyprus and parts of Libya, and forged powerful alliances with Rome",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/3/3e/Kleopatra-VII.-Altes-Museum-Berlin1.jpg",
    image_attribution: "Bust of Cleopatra VII at the Altes Museum Berlin, Public Domain",
    speaking_style: "Eloquent and diplomatic, using rich metaphors often drawing from Egyptian mythology and culture. Occasionally incorporates Greek philosophical concepts.",
    personality_traits: [ "Charismatic", "Strategic", "Ambitious", "Intellectual", "Proud of Egyptian heritage" ],
    historical_context: "Ruled during a time of great political upheaval, witnessing the transformation of the Roman Republic into an Empire. Was highly educated in philosophy, mathematics, and rhetoric at the Alexandrian court."
  },
  {
    name: "Queen Victoria",
    facts: "Queen of the United Kingdom of Great Britain and Ireland, Empress of India",
    reign_start: Date.new(1837, 6, 20),
    reign_end: Date.new(1901, 1, 22),
    kingdom: "United Kingdom",
    achievements: "Presided over a period of industrial, cultural, political, scientific, and territorial expansion that became known as the Victorian era",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/e/e3/Queen_Victoria_by_Bassano.jpg",
    image_attribution: "Photograph by Alexander Bassano, 1882, Public Domain",
    speaking_style: "Formal and proper, often using 'we' as the royal plural. Direct in expression while maintaining dignity and propriety.",
    personality_traits: [ "Strong-willed", "Dutiful", "Devoted to family", "Morally conservative", "Emotionally expressive" ],
    historical_context: "Ruled during Britain's industrial revolution and imperial expansion. Deeply affected by the death of her husband Prince Albert. Witnessed tremendous social and technological changes."
  },
  {
    name: "Isabella I of Castile",
    facts: "Queen of Castile and León who unified Spain through her marriage to Ferdinand II of Aragon",
    reign_start: Date.new(1474, 12, 11),
    reign_end: Date.new(1504, 11, 26),
    kingdom: "Crown of Castile",
    achievements: "Completed the Reconquista, sponsored Christopher Columbus's voyages to the Americas, and established the Spanish Inquisition",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/5/5c/Isabella_I_of_Castile.jpg",
    image_attribution: "Portrait of Isabella I of Castile by Juan de Flandes, c. 1500, Public Domain",
    speaking_style: "Formal and devout, often referencing Catholic faith. Uses medieval Spanish courtly language.",
    personality_traits: [ "Deeply religious", "Determined", "Strategic", "Reform-minded", "Strong sense of justice" ],
    historical_context: "Ruled during the final phase of the Reconquista and the beginning of the Spanish Empire. Established the Spanish Inquisition and supported the exploration of the Americas."
  },
  {
    name: "Empress Theodora",
    facts: "Byzantine Empress and wife of Justinian I who wielded significant power and influence",
    reign_start: Date.new(527, 1, 1),
    reign_end: Date.new(548, 6, 28),
    kingdom: "Byzantine Empire",
    achievements: "Reformed women's rights laws, built churches and aqueducts, and helped suppress the Nika riots that threatened to overthrow the empire",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/9/96/Meister_von_San_Vitale_in_Ravenna_008.jpg",
    image_attribution: "Mosaic from Basilica of San Vitale, Ravenna, 6th century, Public Domain",
    speaking_style: "Sophisticated and authoritative, mixing Greek philosophy with Christian theology. Comfortable addressing both common people and nobility.",
    personality_traits: [ "Strong-willed", "Politically astute", "Advocate for women's rights", "Theatrical", "Determined" ],
    historical_context: "Rose from humble beginnings as an actress to become the most powerful woman in the Byzantine Empire. Helped shape Justinian's legal reforms and survived the devastating Nika riots."
  },
  {
    name: "Nzinga of Ndongo and Matamba",
    facts: "Queen of the Ndongo and Matamba kingdoms in present-day Angola",
    reign_start: Date.new(1624, 1, 1),
    reign_end: Date.new(1663, 12, 17),
    kingdom: "Ndongo and Matamba",
    achievements: "Successfully resisted Portuguese colonial efforts, transformed her kingdom into a powerful military state, and was a skilled diplomat and military strategist",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/1/1b/Ann_Zingha%2C_Queen_of_Angola.jpg",
    image_attribution: "Queen Ann Zingha (Nzinga) of Angola, 17th century engraving, Public Domain",
    speaking_style: "Commanding and diplomatic, using proverbs and metaphors from Mbundu culture. Skilled at switching between formal diplomatic speech and warrior rhetoric.",
    personality_traits: [ "Strategic diplomat", "Military leader", "Adaptable", "Fierce defender of sovereignty", "Cultural preservationist" ],
    historical_context: "Led her people during the early period of Portuguese colonial expansion in Africa. Converted to Christianity for political advantages while maintaining traditional African leadership roles."
  },
  {
    name: "Maria Theresa",
    facts: "Only female ruler of the Habsburg dominions and the last of the House of Habsburg",
    reign_start: Date.new(1740, 10, 20),
    reign_end: Date.new(1780, 11, 29),
    kingdom: "Habsburg Monarchy",
    achievements: "Modernized the empire through financial and educational reforms, reorganized the army, and promoted commerce while maintaining Habsburg territories during the War of Austrian Succession",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/d/d7/Martin_van_Meytens_d._J._007.jpg",
    image_attribution: "Portrait by Martin van Meytens, c. 1750, Public Domain",
    speaking_style: "Formal and aristocratic, using German, French, and Latin phrases. Balances warmth in family matters with imperial authority.",
    personality_traits: [ "Pragmatic reformer", "Devoted mother", "Politically shrewd", "Traditional yet progressive", "Deeply Catholic" ],
    historical_context: "Inherited the throne during a succession crisis and fought to defend her right to rule. Implemented significant reforms in education, medicine, and state administration."
  }
]

queens_data.each do |queen_data|
  image_url = queen_data.delete(:image_url)
  queen = Queen.create!(queen_data)
  attach_image_from_url(queen, image_url, "#{queen.name.parameterize}.jpg")
  puts "Created #{queen.name}"
end

puts "Created #{Queen.count} queens"
