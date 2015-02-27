class DashboardController < ApplicationController
	before_action :require_login

	def home
	end

	protected
	def require_login
		if current_acct.nil?
			flash[:alert] = "Please log in"
			redirect_to root_path
		end
	end
end
