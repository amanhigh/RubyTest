class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def new
    @title = 'Sign up'
    @user = User.new
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
    @title = 'All Users'
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 10)
    @title = @user.name
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followings.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followings.paginate(:page => params[:page])
    render 'show_follow'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => {:success => 'Welcome to the Sample App!'}
    else
      @title = 'Sign up'
      render 'new'
    end
  end

  def edit
    @title = 'Edit user'
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => {:success => 'Profile updated !!'}
    else
      @title = 'Edit user'
      render 'edit'
    end
  end

  def destroy
    if User.find(params[:id]).destroy
      flash[:success] = 'User destroyed'
      redirect_to users_path
    end
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  private
  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end
