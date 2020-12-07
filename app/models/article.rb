class Article < ApplicationRecord
    has_many_attached :images
    belongs_to :user
    def is_belongs_to? user
        Article.find_by(user_id: user.id, id: id)
    end
end
