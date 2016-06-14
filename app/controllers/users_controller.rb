class UsersController < ApplicationController
  def show # 追加
    @user = User.find(params[:id])
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
  

  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end

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
