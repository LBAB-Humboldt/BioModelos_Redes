class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.integer :id_follower
      t.integer :id_user

      t.timestamps
    end
  end
end
