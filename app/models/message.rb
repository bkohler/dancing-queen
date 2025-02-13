class Message < ApplicationRecord
  belongs_to :conversation
  has_one :queen, through: :conversation

  validates :content, presence: true
  validates :role, presence: true, inclusion: { in: %w[user assistant] }

  scope :chronological, -> { order(created_at: :asc) }
  scope :recent_first, -> { order(created_at: :desc) }

  def from_queen?
    role == "assistant"
  end

  def from_user?
    role == "user"
  end
end
