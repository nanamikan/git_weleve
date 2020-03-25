class ChangeIntroToEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :students, :intro, :text
  end
end
