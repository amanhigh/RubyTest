class UsersController < ApplicationController
  before_action :authenticate, :only => [:index, :edit, :update, :destroy, :followers, :following]
  before_action :correct_user, :only => [:edit, :update]
  before_action :admin_user, :only => :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
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
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, flash: {success: 'Welcome to the Sample App!'}
    else
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, :flash => {:success => 'Profile updated !!'}
    else
      render 'edit'
    end
  end

  def destroy
    if User.find(params[:id]).destroy
      flash[:success] = 'User destroyed'
      redirect_to users_path
    end
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
