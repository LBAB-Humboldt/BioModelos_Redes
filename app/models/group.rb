class Group < ActiveRecord::Base


	has_and_belongs_to_many :users
	has_and_belongs_to_many :species
  belongs_to :group_state
  has_many :group_users
  has_many :species_groups


  mount_uploader :logo, GroupLogoUploader

  def notifications
    Group.find_by_sql("
      SELECT * FROM (
        SELECT
          u.id,
          u.name,
          u.bio info,
          gu.updated_at,
          'new_user' type
        FROM users u, group_users gu
        WHERE u.id = gu.user_id AND gu.group_user_state_id = 1 and gu.group_id = "+self.id.to_s+"
        UNION
        SELECT
          s.id,
          s.sci_name name,
          s.family   info,
          sg.updated_at,
          'new_species' type
        FROM species s, species_groups sg
        WHERE sg.species_id = s.id AND sg.species_group_state_id = 1 and sg.group_id = "+self.id.to_s+"
      )
      ORDER BY updated_at DESC")
  end

end