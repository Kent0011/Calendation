class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :calendar]

  def index
    @users = User.all
  end

  def show
  end

  def calendar
    client = Notion::Client.new(token: @user.notion_api_key)
    sorts = [
      {
        'property': 'Date',
        'direction': 'ascending'
      }
    ]
    begin
      response = client.database_query(database_id: @user.notion_database_id, sorts: sorts)
    rescue => e
      flash.now[:alert] = 'Notionデータベースの取得に失敗しました'
      @events = []
    end
    @events = []
    @res = response.results.map do |page|
      @ev = Event.new(name: page.properties.Title.title.first.text.content, start_datetime: page.properties.Date.date.start, end_datetime: page.properties.Date.date.end, category: page.properties.Category[:select][:color], url: page.url)
      @events << @ev
    end
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
