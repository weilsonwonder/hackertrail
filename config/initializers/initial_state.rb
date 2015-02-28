admin = Account.first

if admin.nil?
	admin = Account.new
	admin.email = "admin@hackertrail.com"
	admin.password = "admin123"
	admin.password_confirmation = "admin123"
	admin.ttype = "Super"
	admin.save

	templateAttrs = {
		"Other" => ["Title", "Location", "Description"],
		"Appearance or Signing" => ["Title", "Location", "Description", "Featuring"],
		"Concert or Performance" => ["Title", "Location", "Description", "Featuring", "Price"],
		"Party or Social Gathering" => ["Title", "Location", "Description", "Attire"]
	}
	Template.validTypes.each do |type|
		temp = Template.new
		temp.name = type
		temp.ttype = type
		temp.account = admin
		temp.save

		templateAttrs[type].each_with_index do |attr_name, index|
			attribute = Attr.new
			attribute.name = attr_name
			attribute.position = index
			attribute.template = temp
			attribute.save
		end
	end

	# create samples...
	accounts = [
		{"email" => "jack@hotmail.com", "pword" => "123456"},
		{"email" => "michael007@facebook.com", "pword" => "123456"},
		{"email" => "peter_jack@gmail.com", "pword" => "123456"},
		{"email" => "jane_doe@yahoo.com", "pword" => "123456"}
	]
	events = {
		"jack@hotmail.com" => [{"Title" => "Party @ My House!"}, {"Location" => "My House"}, {"Type" => "Party"}, {"start" => DateTime.tomorrow+7}, {"end" => DateTime.tomorrow+7}],
		"michael007@facebook.com" => [{"Title" => "Church Retreat"}, {"Location" => "Town Harvest"}, {"Type" => "Prayers"}, {"Additional Information" => "Please bring your bible"}, {"start" => DateTime.tomorrow+55}, {"end" => DateTime.tomorrow+57}],
		"peter_jack@gmail.com" => [{"Title" => "New World Order Meeting"}, {"Type" => "General"}, {"Location" => "Town Center"}, {"Invitation" => "Open To All"}, {"start" => DateTime.tomorrow+34}, {"end" => DateTime.tomorrow+34}],
		"jane_doe@yahoo.com" => [{"Title" => "First Event!"}, {"Type" => "Noob"}, {"start" => DateTime.tomorrow+15}, {"end" => DateTime.tomorrow+16}]
	}

	accounts.each do |account|
		acct = Account.new
		acct.email = account["email"]
		acct.password = account["pword"]
		acct.password_confirmation = account["pword"]
		acct.save

		event = Event.new
		events[acct.email].each_with_index do |hash, index|
			if hash.keys.first == "Type"
				event.ttype = hash["Type"]
			elsif hash.keys.first == "start"
				event.start_date = hash["start"]
			elsif hash.keys.first == "end"
				event.end_date = hash["end"]
			else
				att = Attr.new
				att.name = hash.keys.first
				att.value = hash[att.name]
				att.position = index
				att.event = event
				att.save
			end
		end
		event.save

		ownership = Ownership.new
		ownership.event = event
		ownership.account = acct
		ownership.save
	end
end