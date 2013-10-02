class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :species
      t.string :url
      t.date :model_date
      t.integer :rating
      t.string :author

      t.timestamps
    end
  end
end
