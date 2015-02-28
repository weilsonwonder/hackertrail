class DashboardController < ApplicationController
	before_action :requireLogin

	# First page of the dashboard
	def home
		@own_events = current_acct.own_events
		@participations = current_acct.participations
	end

	def createEvent
		if request.get?
			if params.has_key?(:event_type)
				@template = current_acct.templates.where(:name => params[:event_type]).first
				@privacy_types = Event.validTypes
			else
				@event_types = []
				current_acct.templates.each do |template|
					@event_types << template.name
				end
			end
		else # Post method
			template = params.has_key?(:template_id) ? Template.find(params[:template_id].to_i) : nil
			if !template.nil?
				event = Event.new
				event.ttype = template.name
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

	def editEvent
		@event = params.has_key?(:event_id) ? Event.find(params[:event_id].to_i) : nil

		if @event.nil?
			redirect_to dashboard_home_path, :notice => "Event does not exist"
		elsif !current_acct.own_events.include?(@event)
			redirect_to dashboard_home_path, :notice => "You are not the creator of the event"
		end

		if request.get?
			@privacy_types = Event.validTypes
		else # Post method
			if params[:user_action] == "Cancel"
				@event.destroy

				redirect_to dashboard_home_path, :notice => "Event has been cancelled"
			elsif params[:user_action] == "Update"
				@event.privacy_type = params.has_key?(:privacy_type) ? params[:privacy_type] : nil
				@event.capacity = params.has_key?(:capacity) ? params[:capacity] : nil
				@event.start_date = params.has_key?(:start_date) ? params[:start_date] : nil
				@event.end_date = params.has_key?(:end_date) ? params[:end_date] : nil
				@event.save

				@event.attrs.each do |attribute|
					attribute.value = params.has_key?(attribute.name) ? params[attribute.name] : nil
					attribute.save
				end

				redirect_to dashboard_home_path, :notice => "Event has been updated"
			else
				redirect_to dashboard_home_path
			end
		end
	end

	def viewEvent
		@event = params.has_key?(:event_id) ? Event.find(params[:event_id].to_i) : nil

		if @event.nil?
			redirect_to dashboard_home_path, :notice => "Event does not exist"
		end
	end

	def allEvents
		@events = Event.where("? < end_date", DateTime.now)
	end

	def participateEvent
		event = params.has_key?(:event_id) ? Event.find(params[:event_id].to_i) : nil

		if event.nil?
			redirect_to dashboard_home_path, :notice => "Event does not exist"
		end

		if params[:user_action] == "Join"
			if !event.participants.include?(current_acct)
				rsvp = Participation.new
				rsvp.account = current_acct
				rsvp.event = event
				rsvp.save

				redirect_to dashboard_viewEvent_path(:event_id => event.id), :notice => "You joined the event"
			end
		elsif params[:user_action] == "Leave"
			if event.participants.include?(current_acct)
				rsvp = Participation.where(:account => current_acct, :event => event)
				rsvp.destroy_all

				redirect_to dashboard_viewEvent_path(:event_id => event.id), :notice => "You left the event"
			end
		else
			redirect_to dashboard_home_path
		end
	end

	def myTemplates
		@templates = current_acct.templates
	end

	def createTemplate
		if request.post?
			temp = Template.new
			temp.name = params.has_key?(:name) ? params[:name] : ""
			temp.account = current_acct
			temp.save

			attr_name = "attr"
			attr_index = 1
			while params.has_key?(attr_name+attr_index.to_s)
				att = Attr.new
				att.name = params[attr_name+attr_index.to_s]
				att.position = attr_index
				att.template = temp
				att.save
				attr_index = attr_index + 1
			end

			redirect_to dashboard_myTemplates_path, :notice => "Template created"
		end
	end

	def editTemplate
		@template = params.has_key?(:template_id) ? Template.find(params[:template_id].to_i) : nil

		if @template.nil?
			redirect_to dashboard_home_path, :notice => "Template does not exist"
		elsif !current_acct.templates.include?(@template)
			redirect_to dashboard_home_path, :notice => "You are not the owner of the template"
		end

		if request.get?
			@privacy_types = Event.validTypes
		else # Post method
			if params[:user_action] == "Delete"
				if current_acct.templates.count > 0
					@template.destroy
					redirect_to dashboard_myTemplates_path, :notice => "Template deleted"
				else
					redirect_to dashboard_myTemplates_path, :notice => "You cannot delete your last template"
				end
			elsif params[:user_action] == "Update"
				@template.name = params.has_key?(:name) ? params[:name] : ""
				@template.attrs.destroy_all
				@template.save

				attr_name = "attr"
				attr_index = 1
				while params.has_key?(attr_name+attr_index.to_s)
					att = Attr.new
					att.name = params[attr_name+attr_index.to_s]
					att.position = attr_index
					att.template = @template
					att.save
					attr_index = attr_index + 1
				end

				redirect_to dashboard_myTemplates_path, :notice => "Your template has been updated"
			else
				redirect_to dashboard_home_path
			end
		end
	end

	protected
	def requireLogin
		if current_acct.nil?
			redirect_to root_path, :alert => "Please log in"
		end
	end
end
