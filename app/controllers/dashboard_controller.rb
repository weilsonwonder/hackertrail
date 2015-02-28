class DashboardController < ApplicationController
	before_action :requireLogin

	# First page of the dashboard
	def home
		@ownerships = current_acct.ownerships
		@participations = current_acct.participations
	end

	# Create an event
	def createEvent

	end

	protected
	def requireLogin
		if current_acct.nil?
			flash[:alert] = "Please log in"
			redirect_to root_path
		end
	end
end
