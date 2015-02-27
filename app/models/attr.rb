class Attr < ActiveRecord::Base
	include ActiveModel::Dirty

	belongs_to :event
	belongs_to :template
end
