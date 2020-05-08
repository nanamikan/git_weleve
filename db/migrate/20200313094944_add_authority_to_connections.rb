class AddAuthorityToConnections < ActiveRecord::Migration[5.2]
  def change
    
    # オプションだけを後から追加するときは使えない
    # add_index :connections, :group_id, :unique => true
    # add_index :connections, :student_id, :unique => true
     # ⇒既にindexは作成されているのでエラーになる
     
     
    # NOT NULL制約
    change_column_null :connections, :group_id, false
    change_column_null :connections, :student_id, false
    
  # 　group_idは重複してもいいが、student_idは重複しちゃダメ
  # unique制約を使えばいいが、エラーになってしまうのでSQLを直接たたいた
  # alter table connections modify column student_id bigint unique key;
  
  #   ミスでマイグレーションファイルからauthorityカラムを作成できていなかったため
  #   railsのモデルクラスにauthorityメソッドが定義されていない。
  # よって
  # undefined method `authority' というエラーが発生してしまっていた
  # 一度authorityを削除してからもう一度作成する
  add_column :connections, :authority, :boolean, default: false

  end
end
