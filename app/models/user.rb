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


end
