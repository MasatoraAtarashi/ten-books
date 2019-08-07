class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      unless @auth = Authorization.find_from_auth(auth)
        @auth = Authorization.create_from_auth(auth)
      end
      @user = @auth.user
      log_in @user
      params[:remember_me] == 'on' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      @user = User.find_by(email: params[:email].downcase)
      if @user && @user.authenticate(params[:password])
        log_in @user
        params[:remember_me] == 'on' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        flash.now[:danger] = 'アカウント名またはパスワードが正しくありません。'
        @email = params[:email]
        @password = params[:password]
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
