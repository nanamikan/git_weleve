class Student < ApplicationRecord
# ユーザーのレコードと画像を紐づけることができます
     # ユーザーテーブルにカラムを追加する必要はありません。
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  has_many :applies, dependent: :destroy
  has_many :events, through: :applies
  
  has_many :connections, dependent: :destroy
  has_many :groups, through: :connections
  accepts_nested_attributes_for :connections
#   accepts_nested_attributes_for というkeyは、
# 他のモデルを一括で更新、保存できるようにするもの

  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  
  # 存在しなかったらエラーになる
  validates_presence_of  :password,:grade,:email,on: :create
  validates_presence_of :intro ,:preference,:avatar,on: :update
  # validates :grade, if: :grade_only
  # introは40字まで
  validates :intro,    length: { maximum: 40 }     
  

  # def grade_only
  #   if grade==(1||2||3||4)
      
  #   elsif grade==nil
  #     errors.add(:expect_grade, "適切な数字を選択してください")
  #   elsif 
  #     errors.add(:expect_grade, "適切な数字を選択してください")
  #   end
  # end
  
  # rubyでは真偽値を返すメソッドには最後に?を付ける
    def full_profile?
      name?&&preference?&&intro?&&avatar.attached?  
    end
end
