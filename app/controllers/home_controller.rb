class HomeController < ApplicationController
	def index
	end

	def register
		acct = Account.new
		acct.email = params[:registerEmail].downcase
		acct.password = params[:registerPword]
		acct.password_confirmation = params[:registerPword]

		if acct.save
			flash[:notice] = "Registration Complete"
		else
			flash[:alert] = acct.errors.full_messages.to_sentence
		end

		redirect_to root_path
	end
end
