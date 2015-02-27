module Tokenable
	extend ActiveSupport::Concern

	include do
		before_create :generate_token
	end

	def update_token
		self.generate_token
	end

	protected
	def generate_token
		self.token = loop do
			random_token = SecureRandom.urlsafe_base64(64, false)
			break random_token unless self.class.exists?(token: random_token)
		end
	end
end