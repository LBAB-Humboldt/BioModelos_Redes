module ModelsHelper
	def get_models_name
  		Model.uniq.pluck(:species)    
	end
end
