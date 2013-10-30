class Review < ActiveRecord::Base

	validates :user_id, :presence => true
	validates :model_id, :presence => true
	validates :geoJSON, :presence => true

	belongs_to :user
	belongs_to :model
	
end
