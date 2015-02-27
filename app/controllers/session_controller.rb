class SessionController < ApplicationController
	def new
		if !current_user.nil?
			redirect_to dashboard_home_path
		end
	end

	def create
		email = params[:loginEmail]
		pword = params[:loginPword]
		acct = Account.find_by_email(email)

		if !acct.nil?
			success = acct.check_password(pword)
		else
			success = false
		end

		if success
			session[:token] = acct.token
			redirect_to dashboard_home_path
		else
			flash.now.alert = "Invalid username or password"
			redirect_to root_url
		end
	end

	def destroy
		session[:token] = nil
		redirect_to root_url, :notice => "Logged out"
	end
end
