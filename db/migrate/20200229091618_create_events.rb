class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.string :descrip
      t.string :where
      t.integer :group_id
      t.timestamps
    end
  end
end
