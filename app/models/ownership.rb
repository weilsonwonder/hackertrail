class Ownership < ActiveRecord::Base
	include ActiveModel::Dirty

	belongs_to :account
	belongs_to :event

	default_scope { order(:updated_at => :desc) }
end
