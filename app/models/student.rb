class Student < ApplicationRecord
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable
         
  has_many :student_events, dependent: :destroy
  has_many :events, through: :student_events
  has_many :student_groups, dependent: :destroy
  has_many :groups, through: :student_groups
  accepts_nested_attributes_for :student_groups
 
  validates :password, confirmation: true,on: :create
  validates :password_confirmation, presence: true,on: :create
  validates_presence_of  :password,:grade,:email,on: :create
  validates :intro,    length: { maximum: 60 }   
  
  def full_profile?
    name?&&preference?&&intro?&&avatar.attached?  
  end
  
  #current_studentがgroupとしてログインしていて、かつ、閲覧中のページのグループが引数
  def group_authorized(group)
    if self.groups.present?
      if self.student_groups.first.authority?
        if self.groups.first.id == group.id
          return true
        else
          return false
        end
      end
    else
      return false
    end
  end
  
  #current_studentがgroupとしてログインしているかどうかを調べる
  def group_logged_in
    if self.groups.present?
      if self.student_groups.first.authority
        return true
      end
    else
      return false
    end
  end
  
end
