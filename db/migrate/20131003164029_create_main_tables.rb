class CreateMainTables < ActiveRecord::Migration
  def change
    create_table :users do |t|

    	t.string :username
    	t.string :role
    	t.string :location
    	t.text :bio

    	t.timestamps
    end

    create_table :models do |t|

    	t.integer :species_id
    	t.string :url
    	t.date :mode_date
    	t.string :author
    	t.text :description
    	t.integer :rating

    	t.timestamps

    end

    add_index :models, :species_id

    create_table :reviews do |t|

    	t.integer :user_id
    	t.integer :model_id
    	t.text :geoJSON
    	t.timestamps
    end

    add_index :reviews, :user_id
    add_index :reviews, :model_id

    create_table :comments do |t|

    	t.string :title
	    t.string :body
	    t.integer :commentable_id
	    t.string :commentable_type

    	t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]

    create_table :species do |t|

    	t.string :species_name
    	t.timestamps
    end

    add_index :species, :species_name, :unique => true

  end
end
