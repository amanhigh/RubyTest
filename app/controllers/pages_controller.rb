class PagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(:page => params[:id], :per_page => 10)
    end
  end

  def contact
  end

  def about
  end

  def help
  end
end
