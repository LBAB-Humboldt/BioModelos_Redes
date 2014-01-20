class Review < ActiveRecord::Base

	validates :user_id, :presence => true
	validates :model_id, :presence => true
	validates :geoJSON, :presence => true, 
						length: { minimum: 2, maximum: 1999999, too_long: "La anotación supera el tamaño máximo permitido." }

	belongs_to :user
	belongs_to :model
	
end
