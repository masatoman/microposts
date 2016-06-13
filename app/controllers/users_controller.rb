class UsersController < ApplicationController
  def show # 追加
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
  end
  

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功したときの処理
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  before_action :current_user?, only: [:edit, :update]
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :address, :profile, :password, :password_confirmation)
  end
  def current_user?
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
    end
  end
  
end
