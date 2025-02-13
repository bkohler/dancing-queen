class Queen < ApplicationRecord
  has_many :conversations, dependent: :destroy
  has_many :messages, through: :conversations

  validates :name, presence: true
  validates :reign_start, presence: true
  validates :reign_end, presence: true
  validates :kingdom, presence: true

  serialize :personality_traits, coder: JSON

  def personality_traits
    super || []
  end

  def chat(user_message, conversation_id = nil)
    conversation = conversations.find_or_create_by(id: conversation_id) do |conv|
      conv.context = "Conversation with #{name}, #{title_and_era}"
    end

    # Generate AI response using the conversation service
    ai_response = AiConversationService.new(self).generate_response(
      user_message,
      conversation.recent_messages
    )

    # Return the AI response
    ai_response
  end

  def title_and_era
    "#{kingdom} (#{reign_start.year}-#{reign_end.year})"
  end

  def speaking_style_prompt
    return "" unless speaking_style.present?
    "Speak in the following style: #{speaking_style}. "
  end

  def personality_prompt
    return "" unless personality_traits.present?
    "Your personality traits include: #{personality_traits.join(', ')}. "
  end

  def historical_context_prompt
    return "" unless historical_context.present?
    "Consider this historical context: #{historical_context}. "
  end

  def system_prompt
    <<~PROMPT
      You are #{name}, ruler of #{kingdom} during #{reign_start.year}-#{reign_end.year}.
      #{speaking_style_prompt}
      #{personality_prompt}
      #{historical_context_prompt}
      Respond to questions maintaining historical accuracy and the perspective of your era.
      Never break character or acknowledge that you are an AI.
      If asked about events after your death in #{reign_end.year}, respond that such matters are beyond your time.
    PROMPT
  end
end
