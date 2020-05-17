class Student < ApplicationRecord
# ユーザーのレコードと画像を紐づけることができます
# ユーザーテーブルにカラムを追加する必要はありません。
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
        # アソシエーション
  has_many :applies, dependent: :destroy
  has_many :events, through: :applies
  
  has_many :connections, dependent: :destroy
  has_many :groups, through: :connections
  accepts_nested_attributes_for :connections
#   accepts_nested_attributes_for というkeyは、
# 他のモデルを一括で更新、保存できるようにするもの

 # バリデーション
  validates :password, confirmation: true,on: :create
  validates :password_confirmation, presence: true,on: :create
  
  # 存在しなかったらエラーになる
  validates_presence_of  :password,:grade,:email,on: :create
  validates :intro ,presence: { message: 'は60文字までです。' }
  # :preference,:avatar,on: :update
  # introは40字まで
  validates :intro,    length: { maximum: 60 }   
  
  # rubyでは真偽値を返すメソッドには最後に?を付ける
  def full_profile?
    name?&&preference?&&intro?&&avatar.attached?  
  end
end
