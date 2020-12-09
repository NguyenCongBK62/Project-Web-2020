class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar, dependent: :destroy
  has_many :articles, dependent: :destroy
  
  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      nil
    end
  end
end
