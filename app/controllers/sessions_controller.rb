class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      log_in @user
      p params[:remember_me]
      params[:remember_me] == 'on' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = 'アカウント名またはパスワードが正しくありません。'
      @email = params[:email]
      @password = params[:password]
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
