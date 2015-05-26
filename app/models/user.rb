class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews
  has_many :ratings
  has_and_belongs_to_many :groups
  has_many :user_relationships

  def users_most_reviews
  	User.find_by_sql("SELECT U.id AS id, U.name AS Name, COUNT(R.id) AS Ediciones
						FROM users AS U
 						INNER JOIN reviews AS R ON U.id = R.user_id
						GROUP BY U.name
						ORDER BY COUNT(R.id) DESC
						LIMIT 10")
  end

  def own_notifications
    User.find_by_sql("
    SELECT * FROM (
      SELECT
      g.id,
      g.name,
      gu.updated_at,
      'group_action' type,
      gus.name state,
      gu.group_user_state_id state_id
      FROM groups g, group_users gu, group_user_states gus
      WHERE g.id = gu.group_id AND gus.id = gu.group_user_state_id AND gu.user_id = " + self.id.to_s + "
      UNION
      SELECT
      m.id,
      s.sci_name name,
      r.updated_at,
      'review' type,
      'none'   state,
      20 state_id
      FROM reviews r, models m, species s
      WHERE m.id = r.model_id and s.id=m.species_id AND r.user_id = " + self.id.to_s + "
    )ORDER BY updated_at LIMIT 35 ")
  end

  def wall_notifications
    following = UserRelationship.where(:follower_id => self.id)
    my_groups = GroupUser.where(:user_id => self.id, :group_user_state_id =>  1)
    user_list = '0'
    group_list = '0'

    following.each do |f|
      user_id = ','+f.user_id.to_s
      user_list += user_id
    end

    my_groups.each do |f|
      group_id = ','+f.group_id.to_s
      group_list += group_id
    end

    User.find_by_sql("
      SELECT * FROM (
        SELECT
          g.id,
          g.name,
          gu.user_id,
          u.name user_name,
          gu.updated_at,
          'new_user' type
        FROM groups g, group_users gu, users u
        WHERE g.id = gu.group_id AND u.id = gu.user_id AND gu.group_user_state_id = 1 AND gu.group_id in (" + group_list + ")
        UNION
        SELECT
          g.id,
          g.name,
          sg.species_id,
          s.sci_name user_name,
          sg.updated_at,
          'new_specie' type
        FROM groups g, species_groups sg, species_group_states gus, species s
        WHERE g.id = sg.group_id AND s.id = sg.species_id AND sg.species_group_state_id = 1 AND sg.group_id in (" + group_list + ")
        UNION
        SELECT
          m.id,
          s.sci_name name,
          r.user_id,
          u.name user_name,
          r.updated_at,
          'review' type
        FROM reviews r, models m, species s, users u
        WHERE m.id = r.model_id and s.id=m.species_id AND u.id = r.user_id AND r.user_id in (" + user_list + ")
      )ORDER BY updated_at DESC LIMIT 35
    ")
  end

end
