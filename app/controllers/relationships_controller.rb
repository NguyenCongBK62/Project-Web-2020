class RelationshipsController < ApplicationController
    before_action :logged_in_user
    def create
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end
    def destroy
        @user = Relationship.find(params[:id]).followed
        current_user.unfollow(@user)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end
    def logged_in_user
        unless user_signed_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    
        def correct_user
          @user = User.find(params[:id])
          redirect_to(root_url) unless @user == current_user
        end
    end
end