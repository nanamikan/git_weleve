class ChangeIntroToEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :intro, :text
  end
end
