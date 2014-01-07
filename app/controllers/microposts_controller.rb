class MicropostsController < ApplicationController
  before_filter :authenticate

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to root_path, :flash => {:success => ' Micropost created!'}
    else
      @feed_items = current_user.feed.paginate(:page => params[:id], :per_page => 10)
      render 'pages/home'
    end
  end

  def destroy
    post = Micropost.find_by_id(params[:id])
    if post && post.destroy
      redirect_to root_path, :flash => {:success => 'Micropost deleted'}
    else
      redirect_to root_path, :flash => {:error => 'Micropost deletion failed'}
    end
  end
end