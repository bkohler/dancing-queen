class QueensController < ApplicationController
  def index
    @queen = Queen.order("RANDOM()").first
  end
end
