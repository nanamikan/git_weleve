class AddGroupIdToStudents < ActiveRecord::Migration[5.2]
  def change
     add_column :students, :group_id, :integer
     add_column :students, :intro, :integer
  end
end
