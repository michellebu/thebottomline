class RegisterController < ApplicationController

  def new
    render "index"
  end
  
  def create
    @user = User.new params[:user]
    @valid = @user.valid?
    errors = []
    if params[:confirm] != params[:user][:password]
      flash[:error] = errors << "Passwords do not match"
      @valid = false
    end
    if not @valid
      flash[:error] = @user.errors.full_messages.concat(errors).join "<br>"
      redirect_to register_path
    else
      flash[:notice] = "Thanks for signing up! You're ready to send cards"
      @user.save
      session[:userid] = @user.id
      session[:name] = @user.name
      UserMailer.register_email(@user).deliver
      redirect_to send_path
    end
  end
  
end
