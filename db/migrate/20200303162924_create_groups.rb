class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :category
      t.string :what_to_do
      t.text :intro
      t.timestamps
    end
  end
end
