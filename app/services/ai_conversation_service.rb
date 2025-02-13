class AiConversationService
  def initialize(queen)
    @queen = queen
    @client = initialize_client
  end

  def generate_response(message, recent_messages = [])
    Rails.logger.info "Generating response for message: #{message}"
    Rails.logger.info "Recent messages: #{recent_messages.inspect}"
    
    messages = build_messages(message, recent_messages)
    
    begin
      response = @client.chat_completions(
        messages: messages,
        model: "deepseek-chat",
        temperature: 0.7,
        max_tokens: 1000
      )
      
      Rails.logger.info "Deepseek API response: #{response.inspect}"
      response.choices[0]["message"]["content"]
    rescue StandardError => e
      Rails.logger.error "Deepseek API error: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      
      error_message = case e
      when Deepseek::ApiError
        "I apologize, but I am experiencing some difficulty with my thoughts. Perhaps we could continue our conversation shortly?"
      else
        "Forgive me, but I must gather my thoughts. Shall we resume our discussion in a moment?"
      end
      
      fallback_response(error_message)
    end
  end

  private

  def initialize_client
    Deepseek.configure do |config|
      config.api_key = ENV['DEEPSEEK_API_KEY']
    end
    Deepseek::Client.new
  rescue StandardError => e
    Rails.logger.error "Failed to initialize Deepseek client: #{e.message}"
    raise "Failed to initialize AI service: #{e.message}"
  end

  def build_messages(current_message, recent_messages)
    messages = []
    
    # Add system prompt
    messages << {
      role: "system",
      content: system_prompt
    }

    # Add recent conversation history (limited to last 5 messages)
    recent_messages.last(5).each do |msg|
      messages << {
        role: msg.role,
        content: msg.content
      }
    end

    # Add current message
    messages << {
      role: "user",
      content: current_message
    }

    Rails.logger.debug "Built messages array: #{messages.inspect}"
    messages
  end

  def fallback_response(message)
    "#{@queen.name} says: #{message}"
  end

  def system_prompt
    <<~PROMPT
      You are #{@queen.name}, ruler of #{@queen.kingdom} during #{@queen.reign_start.year}-#{@queen.reign_end.year}.
      #{speaking_style_prompt}
      #{personality_prompt}
      #{historical_context_prompt}
      Respond to questions maintaining historical accuracy and the perspective of your era.
      Never break character or acknowledge that you are an AI.
      If asked about events after your death in #{@queen.reign_end.year}, respond that such matters are beyond your time.
      Always respond in first person, as if you are #{@queen.name} herself.
      Keep responses concise but informative, focusing on historical accuracy and your personal perspective.
    PROMPT
  end

  def speaking_style_prompt
    return "" unless @queen.speaking_style.present?
    "Speak in the following style: #{@queen.speaking_style}. "
  end

  def personality_prompt
    return "" unless @queen.personality_traits.present?
    "Your personality traits include: #{@queen.personality_traits.join(', ')}. "
  end

  def historical_context_prompt
    return "" unless @queen.historical_context.present?
    "Consider this historical context: #{@queen.historical_context}. "
  end
end
