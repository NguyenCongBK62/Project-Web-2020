class Article < ApplicationRecord
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    has_many_attached :images
    belongs_to :user
    def is_belongs_to? user
        Article.find_by(user_id: user.id, id: id)
    end
    
    def is_liked user
        Like.find_by(user_id: user.id, article_id: id)
    end
    
    def is_bookmarked user
        Bookmark.find_by(user_id: user.id, article_id: id)
    end
end
