class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :loggout_user, only: [:create, :new]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
    @users_top = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in(@user)
      remember(@user)
      flash[:success] = "Welcome to the Photo Blog!"
      redirect_to @user
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
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def show
    @user = User.find(params[:id])
    @micropost = current_user.microposts.build if logged_in?
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 15)
  end

  def following
    @title = "Following"
    @feed_items = current_user.feed.paginate(page: params[:feed_page], per_page: 10)
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:user_page], per_page: 6)
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 6)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :ava)
      
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def loggout_user
      unless !logged_in?
        flash[:danger] = "Please log out."
        redirect_to current_user
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
