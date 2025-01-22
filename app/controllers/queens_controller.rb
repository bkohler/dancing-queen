class QueensController < ApplicationController
  def index
    @queen = params[:spin] ? Queen.order("RANDOM()").first : nil
  end
end
