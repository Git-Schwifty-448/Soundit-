class SessionsController < ApplicationController

    def new
    end

    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '0' ? remember(user) : forget(user)
        redirect_to root_url
      else
        flash.now[:danger] = 'Invalid email/password combination'
        redirect_to signup_path
      end
    end

	def current_user?(user)
    	user == current_user
	end

	def current_user
    	if(user_id = session[:user_id])
    		@current_user ||= User.find_by(id: user_id)
		end
	end

    def destroy
      log_out if logged_in?
      redirect_to root_url
    end
  end
