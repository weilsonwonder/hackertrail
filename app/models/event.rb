class Event < ActiveRecord::Base
	include ActiveModel::Dirty

	before_save :checkNil

	has_many :participations
	has_many :ownerships
	has_many :attrs

	def self.validTypes
		return [
			"Private",
			"Public"
		]
	end
	validates :privacy_type, inclusion: {:in => validTypes, :allow_nil => true}

	protected
	def checkNil
		self.privacy_type.nil? ? self.privacy_type = self.class.validTypes.first : nil
		self.start_date.nil? ? self.start_date = DateTime.now : nil
		self.end_date.nil? ? self.end_date = self.start_date.tomorrow : nil
	end
end
