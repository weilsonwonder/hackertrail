class Ownership < ActiveRecord::Base
	include ActiveModel::Dirty

	belongs_to :account
	belongs_to :event
end
