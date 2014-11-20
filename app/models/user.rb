class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews
  has_many :ratings
  has_and_belongs_to_many :groups

  def users_most_reviews
  	User.find_by_sql(
      "SELECT t.user_id AS id, U.name AS Name, SUM(number) AS Aportes
      FROM( 
            SELECT user_id, count(user_id) AS number
            FROM comments
            GROUP by user_id
            
            UNION ALL

            SELECT user_id, count(user_id) AS number
            FROM reviews
            GROUP by user_id
            
            UNION ALL
            
            SELECT user_id, count(user_id) AS number
            FROM point_comments
            GROUP by user_id
            
            UNION ALL
            
            SELECT user_id, count(user_id) AS number
            FROM (
              SELECT DISTINCT user_id, species_id
              FROM eco_variables_species
            ) c
            GROUP by user_id
      ) t
      INNER JOIN users AS U ON U.id = t.user_id
      GROUP by id
      ORDER by Aportes DESC
      LIMIT 10;"
    )
  end

end
