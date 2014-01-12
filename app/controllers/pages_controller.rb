class PagesController < ApplicationController
  def home
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:id], :per_page => 10)
    end
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About Us'
  end

  def help
    @title = 'Help'
  end
end
