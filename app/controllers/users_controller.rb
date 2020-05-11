class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_gossips = @user.gossips
  end

  def new
    
  end

  def create
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], first_name: params[:first_name], last_name: params[:last_name], age: params[:age], city_id: City.first.id)

    if @user.save
      log_in(@user)
      redirect_to gossips_path
    else
      render 'new'
    end
  end
end
