class AddNameToStudents < ActiveRecord::Migration[5.2]
  def change
   add_column :students, :preference, :string
  end
end
