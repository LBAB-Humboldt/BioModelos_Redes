class Group < ActiveRecord::Base


	has_and_belongs_to_many :users 
	has_and_belongs_to_many :species
  belongs_to :group_state
  has_many :group_users
  has_many :species_groups


 mount_uploader :logo, GroupLogoUploader

end