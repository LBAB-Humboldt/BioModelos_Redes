module ModelsHelper
	def get_current_user_id
		user_signed_in? ? current_user.id : ''
	end	

	def get_models_name
  		Model.uniq.pluck(:species)    
	end
end
