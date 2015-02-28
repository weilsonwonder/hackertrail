class Event < ActiveRecord::Base
	include ActiveModel::Dirty

	before_save :checkNil

	has_many :participations, :dependent => :destroy
	has_many :ownerships, :dependent => :destroy
	has_many :attrs, :dependent => :destroy

	def self.validTypes
		return [
			"Private",
			"Public"
		]
	end
	validates :privacy_type, inclusion: {:in => validTypes, :allow_nil => true}

	default_scope { order(:start_date => :desc) }

	protected
	def checkNil
		self.privacy_type.nil? ? self.privacy_type = self.class.validTypes.first : nil
		self.start_date.nil? ? self.start_date = DateTime.now : nil
		self.end_date.nil? ? self.end_date = self.start_date.tomorrow : nil
	end
end
