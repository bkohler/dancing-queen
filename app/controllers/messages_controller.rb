class MessagesController < ApplicationController
  before_action :set_queen
  before_action :set_conversation

  def create
    Rails.logger.info "Message params: #{message_params.inspect}"
    Rails.logger.info "Creating message in conversation: #{@conversation.id}"

    # Save user's message
    @message = @conversation.add_message(message_params[:content], 'user')

    # Get AI response
    ai_response = @queen.chat(message_params[:content], @conversation.id)
    @ai_message = @conversation.add_message(ai_response, 'assistant')

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append('messages',
            partial: 'messages/message',
            locals: { message: @message }
          ),
          turbo_stream.append('messages',
            partial: 'messages/message',
            locals: { message: @ai_message }
          ),
          turbo_stream.update('message_form',
            partial: 'messages/form',
            locals: { queen: @queen, conversation: @conversation }
          )
        ]
      end
      format.html { redirect_to @queen }
    end
  rescue StandardError => e
    Rails.logger.error "Chat Error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append('messages',
            html: "<div class='text-red-500 p-4 rounded-lg bg-red-50 mb-4'>#{e.message}</div>"
          ),
          turbo_stream.update('message_form',
            partial: 'messages/form',
            locals: { queen: @queen, conversation: @conversation }
          )
        ]
      end
      format.html do
        flash[:error] = e.message
        redirect_to @queen
      end
    end
  end

  private

  def set_queen
    @queen = Queen.find(params[:queen_id])
  end

  def set_conversation
    @conversation = @queen.conversations.find_or_create_by(id: params[:conversation_id]) do |conv|
      conv.context = "Conversation with #{@queen.name}"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
