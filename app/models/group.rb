class Group < ApplicationRecord

  has_one_attached :image 
   
  # 親テーブルのデータが消えたら子テーブル(connections)のデータも消す
  has_many :connections, dependent: :destroy
  has_many :students, through: :connections
  accepts_nested_attributes_for :connections
  
  has_many :events, dependent: :destroy
 
  validates :category,  length: { maximum: 5 }     
  validates :what_to_do,  length: { maximum: 10 }     
  validates :intro, length: { maximum: 60 }   
  validates_presence_of :name,:what_to_do,:category,:intro ,:image, on: :update
 
  def full_profile?
   name?&&category?&&what_to_do?&&intro?&&image.attached?  
  end
  
  def group_authorized?(current_student)
    if current_student.authorized?
      if current_student.groups.first.id==self.id
        return true
      end
    else
      return false
    end
  end
       
end
