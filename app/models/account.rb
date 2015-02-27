class Account < ActiveRecord::Base
	include ActiveModel::Dirty
	include Tokenable

	attr_accessor :password

	before_save :encrypt_password, :generate_token, :checkNil
	after_save :clear_password

	has_many :profiles
	has_many :participations
	has_many :ownerships
	has_many :templates

	def self.validTypes
		return [
			"Normal",
			"Super"
		]
	end
	validates :ttype, inclusion: {:in => validTypes, :allow_nil => true}
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})\Z/i
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :length => {:minimum => 6, :maximum => 36}, :confirmation => true


	def check_password(pword)
		if pword.present?
			encrypted_pword = BCrypt::Engine.hash_secret(pword, self.salt)
			if encrypted_pword.eql? self.encrypted_password
				return true
			end
		end
		return false
	end

	protected
	def encrypt_password
		if self.password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		self.password = nil
	end

	def checkNil
		self.ttype.nil? ? self.ttype = self.class.validTypes.first : nil
	end
end
