class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  include SessionsHelper
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      flash[:success] = "ユーザー作成に成功しました"
      redirect_back_or user
    else
      render 'new'
      flash[:error] = "ユーザー作成に失敗しました"
    end
  end

  def login_form
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @challenges = @user.challenges
  end

  def edit
    @user = User.find_by(id: params[:id])
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

  def feed
    Challemge.where("user_id = ?", id)
  end

  private def user_params
      params.require(:user).permit(:nickname, :email, :password,
                                   :password_confirmation)
  end

  # beforeフィルター

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
