class CreateAccounts < ActiveRecord::Migration
	def change
		create_table :accounts do |t|
			t.text :email
			t.text :encrypted_password
			t.text :salt
			t.text :token
			t.text :ttype
			t.timestamps
		end
	end
end
