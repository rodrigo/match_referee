class MatchesController < ApplicationController

  def index
    render json: Match.all.map(&:details) # should be paginated
  end

  def show
    render json: Match.find(params[:id]).details
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def kills_per_weapon
    render json: Match.find(params[:id]).kills_per_weapon
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end
end
