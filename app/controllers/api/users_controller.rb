class Api::UsersController < ApplicationController
  def index
    @users = User.all
    @users = @users.map do |user|
      {
          id: user.id,
          name: user.name,
          email: user.email,
          comments: user.comments,
          picture: user.picture,
          job: user.job,
      }
    end
    render json: @users
  end
end
