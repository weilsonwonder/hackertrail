class Template < ActiveRecord::Base
	include ActiveModel::Dirty

	before_save :checkNil

	belongs_to :account
	has_many :attrs, :dependent => :destroy

	def self.validTypes
		return [
			"Other",
			"Appearance or Signing",
			"Concert or Performance",
			"Party or Social Gathering"
		]
	end
	validates :ttype, :inclusion => {:in => validTypes, :allow_nil => true}

	protected
	def checkNil
		self.ttype.nil? ? self.ttype = self.class.validTypes.first : nil
	end
end
