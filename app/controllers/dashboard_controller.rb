class DashboardController < ApplicationController
	before_action :requireLogin

	# First page of the dashboard
	def home
		@ownerships = current_acct.ownerships
		@participations = current_acct.participations
	end

	# Create an event
	def createEvent
		if request.get?
			if params.has_key?(:event_type)
				if Template.validTypes.include?(params[:event_type])
					@template = current_acct.templates.where(:ttype => params[:event_type]).first
					@privacy_types = Event.validTypes
				else
					@event_types = []
					current_acct.templates.each do |template|
						@event_types << template.ttype
					end
				end
			else
				@event_types = []
				current_acct.templates.each do |template|
					@event_types << template.ttype
				end
			end
		else # Post method
			template = params.has_key?(:template_id) ? Template.find(params[:template_id].to_i) : nil
			if !template.nil?
				event = Event.new
				event.ttype = template.ttype
				event.privacy_type = params.has_key?(:privacy_type) ? params[:privacy_type] : nil
				event.capacity = params.has_key?(:capacity) ? params[:capacity] : nil
				event.start_date = params.has_key?(:start_date) ? params[:start_date] : nil
				event.end_date = params.has_key?(:end_date) ? params[:end_date] : nil
				event.save

				ownership = Ownership.new
				ownership.account = current_acct
				ownership.event = event
				ownership.save

				template.attrs.each do |attribute|
					att = Attr.new
					att.name = attribute.name
					att.position = attribute.position
					att.value = params.has_key?(att.name) ? params[att.name] : nil
					att.event = event
					att.save
				end

				redirect_to dashboard_home_path, :notice => "Event created"
			end
		end
	end

	def viewEvent

	end

	def allEvents
	end

	protected
	def requireLogin
		if current_acct.nil?
			redirect_to root_path, :alert => "Please log in"
		end
	end
end
