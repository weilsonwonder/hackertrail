class Ownership < ActiveRecord::Base
	include ActiveModel::Dirty

	belongs_to :account
	belongs_to :event

	validates :account_id, :uniqueness => { :scope => :event_id }

	default_scope { order(:updated_at => :desc) }
end
