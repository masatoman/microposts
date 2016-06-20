class UsersController < ApplicationController
  before_action :current_user?, only: [:edit, :update]
  before_action :get_user, only: [:show, :edit, :update, :current_user?]
  def show # 追加
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      # 更新に成功したときの処理
      redirect_to @user
    else
      render 'edit'
    end
  end
  

  def followings
    @user = User.find(params[:user_id])
    @users = @user.following_users
  end
  
  def followers
    @user = User.find(params[:user_id])
    @users = @user.follower_users
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :address, :profile, :password, :password_confirmation)
  end
  def current_user?
    if current_user != @user
      redirect_to root_path
    end
  end
  def get_user
    @user = User.find(params[:id])
  end
end
