class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, limit: 64

      t.timestamps
    end

    add_indx :categories, :name, unique: true
  end
end
