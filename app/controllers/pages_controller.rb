class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @tournament = Tournament.new
      @feed_items = current_user.player.feed.paginate(:page => params[:page])
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

end
