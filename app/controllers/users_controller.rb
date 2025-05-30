class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :calendar]

  def index
    @users = User.all
  end

  def show
  end

  def calendar
    @year = (params[:year] || Date.today.year).to_i
    @month = (params[:month] || Date.today.month).to_i

    @events = FetchEvents.event_list(@user)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user.id), notice: 'ユーザーが正常に作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'ユーザー情報が正常に更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'ユーザーが正常に削除されました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :notion_api_key, :notion_database_id)
  end
end
