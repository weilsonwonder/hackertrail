class Profile < ActiveRecord::Base
	include ActiveModel::Dirty

	belongs_to :account
end
