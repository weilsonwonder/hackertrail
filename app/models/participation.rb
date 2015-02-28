class Participation < ActiveRecord::Base
	include ActiveModel::Dirty

	before_save :checkNil

	belongs_to :account
	belongs_to :event

	def self.validTypes
		return [
			"Private",
			"Public"
		]
	end
	validates :privacy_type, inclusion: {:in => validTypes, :allow_nil => true}

	default_scope { order(:updated_at => :desc) }

	protected
	def checkNil
		self.privacy_type.nil? ? self.privacy_type = self.class.validTypes.first : nil
	end
end
