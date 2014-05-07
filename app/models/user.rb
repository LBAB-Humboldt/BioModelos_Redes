class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews
  has_many :ratings
  has_and_belongs_to_many :groups

  def users_most_reviews
  	User.find_by_sql("SELECT U.name AS Name, COUNT(R.id) AS Ediciones
						FROM users AS U
 						INNER JOIN reviews AS R ON U.id = R.user_id
						GROUP BY U.name
						ORDER BY COUNT(R.id) DESC
						LIMIT 10")
  end




end
