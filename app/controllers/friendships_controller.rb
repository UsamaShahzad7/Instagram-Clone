# frozen_string_literal: true

class FriendshipsController < ApplicationController
  include CurrentProfile

  def follow
    current_profile
    id = params[:id]
    Friendship.create(follower_id: current_profile, followed_id: id.to_i)
    redirect_to profile_path(id)
  end

  def unfollow
    current_profile
    id = params[:id]
    friendship = Friendship.find_by(followed_id: id.to_i, follower_id: current_profile)
    friendship.destroy
    redirect_to profile_path(id)
  end
end
