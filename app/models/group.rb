class Group < ApplicationRecord

  has_one_attached :image 
   
  # 親テーブルのデータが消えたら子テーブル(connections)のデータも消す
  has_many :connections, dependent: :destroy
  has_many :students, through: :connections
  accepts_nested_attributes_for :connections
  
  has_many :events, dependent: :destroy
 
  validates :category,    length: { maximum: 5 }     
  validates :what_to_do,    length: { maximum: 10 }     
  validates :intro,    length: { maximum: 60 }   
   

  validates_presence_of :name,:what_to_do,:category,:intro ,:image, on: :update
 
  def full_profile?
   name?&&category?&&what_to_do?&&intro?&&image.attached?  
  end
  
  def authorized?(current_student)
      # <!--ログイン中の生徒がグループアカウントを保持-->
    if current_student.groups.present? 
      current_student.groups.first.id==self.id &&current_student.connections.first.authority 
      # <!--今ログイン中のユーザーのグループが今から見るグループページのグループと一致するなら-->
      # <!--@group.idは1だがcurrent_student.groups.idsだと[1]となるので一致しない-->
      # <!--.firstを付けると1になる-->
     # <!--authorityがtrueなら-->
    else
      return false
    end
  end
       
end
