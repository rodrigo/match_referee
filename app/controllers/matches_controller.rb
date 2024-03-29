class MatchesController < ApplicationController

  def index
    render json: Match.all.map(&:details)
  end

  def show
    render json: Match.find(params[:id]).details
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end
end
