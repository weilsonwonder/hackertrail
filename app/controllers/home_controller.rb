class HomeController < ApplicationController
	def index
	end

	def register
		acct = Account.new
		acct.email = params[:registerEmail].downcase
		acct.password = params[:registerPword]
		acct.password_confirmation = params[:registerPword]

		if acct.save
			initializeDefaults(acct)

			flash[:notice] = "Registration Complete"
		else
			flash[:alert] = acct.errors.full_messages.to_sentence
		end

		redirect_to root_path
	end

	protected
	def initializeDefaults(acct=nil)
		if !acct.nil?
			admin = Account.first

  		# Copy default templates with attributes
  		admin.templates.each do |template|
  			temp = Template.new
  			temp.name = template.name
  			temp.ttype = template.ttype
  			temp.account = acct
  			temp.save

  			template.attrs.each do |attribute|
  				att = Attr.new
  				att.name = attribute.name
  				att.position = attribute.position
  				att.template = temp
  				att.save
  			end
  		end
  	end
  end
end
