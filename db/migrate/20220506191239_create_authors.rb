class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :username, limit: 64

      t.timestamps
    end

    add_indx :authors, :username, unique: true
  end
end
