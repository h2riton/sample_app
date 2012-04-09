class PlayersController < ApplicationController
  before_filter :authenticate,        :only => [:new, :create, :edit, :update, :destroy]
  before_filter :registered_player,   :only => :new
  before_filter :correct_user_player, :only => [:edit, :update]
  before_filter :authorized_user,     :only => :destroy
  
  def new
    @title = "Set player"
    @player = Player.new if signed_in?
  end
  
  def create
    @player = current_user.create_player(params[:player])
    if @player.save
      flash[:success] = "Player created!"
      redirect_to user_path(current_user)
    else
      @title = "Set player"
      render 'new'
    end
  end
  
  def edit
    @player = Player.find(params[:id])
    @title = "Edit player"
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      flash[:success] = "Nickname updated."
      redirect_to user_path(current_user)
    else
      @title = "Edit player"
      render 'edit'
    end
  end

  def destroy
    @player.destroy
    redirect_back_or user_path(current_user)
  end
  
  private
  
    def registered_player
      redirect_to(user_path(current_user)) unless !current_user.player
    end
    
    def correct_user_player
      @player = Player.find(params[:id])
      redirect_to(root_path) unless current_user.id == @player.user_id
    end
    
    def authorized_user
      @player = current_user.player
      redirect_to root_path if !@player
    end

end
