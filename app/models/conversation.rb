class Conversation < ApplicationRecord
  belongs_to :queen
  has_many :messages, dependent: :destroy

  validates :queen, presence: true

  def recent_messages(limit = 5)
    messages.order(created_at: :asc).last(limit)
  end

  def add_message(content, role)
    raise ArgumentError, "Message content can't be blank" if content.blank?
    raise ArgumentError, "Invalid role" unless %w[user assistant].include?(role)

    messages.create!(
      content: content,
      role: role
    ).tap do |message|
      Rails.logger.info "Created message: #{message.inspect}"
    end
  end
end
