class ChangeAppliesToStudentEvents < ActiveRecord::Migration[5.2]
  def change
    rename_table :applies, :student_events
  end
end
