# Interactive Historical Queens Dialogue System Implementation Plan

## 1. Ruby Integration Setup
- Add Deepseek Ruby gem to the project
- Configure API credentials in Rails credentials
- Create service objects for AI interactions
- Implement conversation management within Rails

### Key Components:
```ruby
# app/services/ai_conversation_service.rb
class AiConversationService
  def initialize(queen)
    @queen = queen
    @client = Deepseek::Client.new(api_key: Rails.application.credentials.deepseek[:api_key])
  end

  def generate_response(user_message, conversation_history)
    prompt = PromptBuilder.new(@queen).build(user_message, conversation_history)
    response = @client.chat(prompt)
    format_response(response)
  end
end

# app/services/prompt_builder.rb
class PromptBuilder
  def initialize(queen)
    @queen = queen
  end

  def build(user_message, conversation_history)
    {
      system_prompt: historical_context_prompt,
      conversation_history: conversation_history,
      user_message: user_message
    }
  end

  private

  def historical_context_prompt
    "You are #{@queen.name}, #{@queen.title} of #{@queen.kingdom} (#{@queen.reign_start}-#{@queen.reign_end}). 
     Respond in the style and language of your era, incorporating your known personality 
     traits and historical context..."
  end
end
```

## 2. Database Schema Updates
- Add conversation and message tables
- Add personality and dialogue attributes to queens

### New Database Migrations:
```ruby
# db/migrate/YYYYMMDDHHMMSS_create_conversations.rb
class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.references :queen, null: false, foreign_key: true
      t.text :context
      t.timestamps
    end

    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.text :content
      t.string :role
      t.timestamps
    end

    add_column :queens, :speaking_style, :text
    add_column :queens, :personality_traits, :text, array: true
    add_column :queens, :historical_context, :text
  end
end
```

## 3. Model Updates
```ruby
# app/models/queen.rb
class Queen < ApplicationRecord
  has_many :conversations
  has_many :messages, through: :conversations
  
  def chat(user_message, conversation_id = nil)
    conversation = conversations.find_or_create_by(id: conversation_id)
    AiConversationService.new(self).generate_response(
      user_message, 
      conversation.messages.order(:created_at).last(5)
    )
  end
end

# app/models/conversation.rb
class Conversation < ApplicationRecord
  belongs_to :queen
  has_many :messages, dependent: :destroy
end

# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :conversation
  validates :role, inclusion: { in: %w[user assistant] }
end
```

## 4. Frontend Implementation
- Add chat interface to queen's page
- Implement real-time updates with Turbo Streams
- Style conversation UI with period-appropriate themes

### View Updates:
```erb
# app/views/queens/_chat.html.erb
<div class="chat-container" data-controller="chat">
  <div class="messages" data-chat-target="messages">
    <%= render partial: "messages", locals: { messages: @conversation.messages } %>
  </div>

  <%= form_with(model: [@queen, Message.new], 
                data: { action: "chat#submit" }) do |f| %>
    <%= f.text_area :content, 
                    data: { chat_target: "input" },
                    placeholder: "Ask #{@queen.name} a question..." %>
    <%= f.submit "Send", class: "send-button" %>
  <% end %>
</div>
```

## 5. Controller Updates
```ruby
# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  def create
    @queen = Queen.find(params[:queen_id])
    @conversation = @queen.conversations.find_or_create_by(id: params[:conversation_id])
    
    @message = @conversation.messages.create!(
      content: params[:message][:content],
      role: 'user'
    )

    response = @queen.chat(params[:message][:content], @conversation.id)
    
    @ai_message = @conversation.messages.create!(
      content: response,
      role: 'assistant'
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @queen }
    end
  end
end
```

## 6. Historical Accuracy Features
- Enhance queen data with detailed historical context
- Implement period-specific language processing
- Add fact-checking system

## 7. Testing Strategy
- Unit tests for conversation service
- Integration tests for chat functionality
- Historical accuracy validation
- Performance testing

## 8. Deployment Steps
1. Add Deepseek gem and configure credentials
2. Run database migrations
3. Deploy frontend updates
4. Monitor conversation quality
5. Gather user feedback

## Timeline Estimate
- Ruby Integration: 2 days
- Database Updates: 1 day
- Frontend Implementation: 2 days
- Historical Accuracy Features: 2 days
- Testing: 2 days
- Deployment: 1 day

Total: ~10 days for initial implementation

## Future Enhancements
- Multi-language support
- Voice interactions
- Expanded historical context
- Personalized user experiences
- Integration with historical documents and sources