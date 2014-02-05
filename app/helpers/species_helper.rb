module SpeciesHelper
	def get_species_name
  		Species.uniq.pluck(:sci_name)    
	end

	def get_models_array (models)
	end
end
