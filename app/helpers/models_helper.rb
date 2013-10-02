module ModelsHelper
	def get_species_name
  		Model.uniq.pluck(:species)    
	end
end
