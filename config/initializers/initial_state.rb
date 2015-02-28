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
end