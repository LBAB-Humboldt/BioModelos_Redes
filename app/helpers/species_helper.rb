module SpeciesHelper
	def get_species_name
  		Species.uniq.pluck(:sci_name)    
	end

	def file_exists(modelId)
		filepath = Rails.root.join('public/kmz/'+ Model.find(modelId).img_url.split('.').first + '.kmz')
		if File.exists?(filepath)
          true
        else
          false
        end
	end

	def get_models_array (models)
	end
end
