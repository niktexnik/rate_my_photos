class CompetitionsController < ApplicationController
  def index
    @competitions = Competition.all
  end

  def show
    @competition = Competition.find(params[:id])
    @photos = @competition.photos
  end

  # def create; end

  # def new; end

  # def update; end

  # def destroy; end
end
