class AddAuthority < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :name, :string
  end
end