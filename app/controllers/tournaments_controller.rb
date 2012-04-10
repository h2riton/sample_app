class TournamentsController < ApplicationController
  before_filter :authenticate,    :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @tournament  = current_user.player.tournaments.build(params[:tournament])
    if @tournament.save
      flash[:success] = "Tournament created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @tournament.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      if current_user.player
        @tournament = current_user.player.tournaments.find_by_id(params[:id])
      end
      redirect_to root_path if @tournament.nil?
    end
end