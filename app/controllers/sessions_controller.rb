class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'アカウント名またはパスワードが正しくありません。'
      @email = params[:email]
      @password = params[:password]
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
