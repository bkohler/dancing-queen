class QueensController < ApplicationController
  def index
    @queen = Queen.order("RANDOM()").first
  end

  def biography
    queen = Queen.find(params[:id])

    client = OpenAI::Client.new(
      access_token: Rails.application.credentials.dig(:deepseek, :api_key),
      uri_base: "https://api.deepseek.com/v1",
      request_timeout: 240
    )

    response = client.chat(
      parameters: {
        model: "deepseek-chat",
        messages: [ {
          role: "user",
          content: "Generate a 4-sentence biography about #{queen.name}. Focus on historical facts and achievements."
        } ]
      }
    )

    render json: { biography: response.dig("choices", 0, "message", "content") }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: "Queen not found" }, status: :not_found
  rescue OpenAI::Error => e
    render json: { error: "API Error: #{e.message}" }, status: :service_unavailable
  end
end
