class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title, limit: 64
      t.integer :cook_time
      t.integer :prep_time
      t.text :ingredients
      t.float :ratings
      t.string :cuisine, limit: 32
      t.references :category, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.text :image

      t.timestamps
    end
  end
end
