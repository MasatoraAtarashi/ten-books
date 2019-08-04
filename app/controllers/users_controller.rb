class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy, :likes]
  before_action :correct_user, only: [:edit, :update, :edit_image, :update_image]
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
  end

   def new
    @user = User.new
  end

   def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "登録メールアドレス宛てにメールアドレス認証のメールを送信しました。メールの内容をご確認の上、メールアドレス認証を行ってください。"
      log_in @user
      flash[:success] = "ようこそ！会員登録ありがとうございます！"
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
       flash[:success] = "プロフィールが更新されました"
       redirect_to @user
     else
       render 'edit'
     end
   end

   def edit_image
     @user = User.find(params[:id])
   end

   def update_image
     @user = User.find(params[:id])
     if @user.update_attributes(fileupload_params)
       flash[:success] = "プロフィール画像が更新されました"
       redirect_to @user
     else
       render 'edit_image'
     end
   end

   def destroy
     User.find(params[:id]).destroy
     flash[:success] = "User deleted"
     redirect_to root_url
   end

   def index
     if params[:key]
       @users = User.search(params[:key]).to_a.paginate(page: params[:page], :per_page => 10)
     else
       @users = User.all.to_a.paginate(page: params[:page], :per_page => 10)
     end
   end

   def likes
    @user = User.find(params[:id])
    @users = @user.likes.to_a.paginate(page: params[:page], :per_page => 10)
   end

   private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation, :comments, :job)
    end

    def fileupload_params
      params.require(:user).permit(:picture)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
