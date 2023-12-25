# frozen_string_literal: true

class HomesController < ApplicationController
  include CurrentProfile
  include ProfilePicture
  before_action :check_activation_status
  before_action :restrict_admin

  def index
    if !Profile.account_has_profile(current_account.id).exists?
      redirect_to new_profile_path
    else
      fetch_posts
    end
  end
end

private

def fetch_posts
  @following = Profile.following(current_profile)
  if @following.count >= 1
    following_profiles_post
  else
    recommended_posts
  end
  @post = @post.flatten
  @current_profile_picture = current_profile_picture
end

def following_profiles_post
  @post = []
  @profile = []
  @following.each do |x|
    data = Post.where(profile_id: x)
    @post.append(data) if data.count != 0
    @profile.append(Profile.find_by(id: x))
  end
end

def recommended_posts
  @message = 'Recommended For You'
  follower = Profile.max_followers
  @post = []
  @profile = []
  follower.each do |x|
    profile_id = current_profile
    status_check = Profile.find_by(id: x.followed_id)
    next unless x.followed_id != profile_id && status_check.status != 'private_profile'

    data = Post.where(profile_id: x.followed_id)
    @post.append(data) if data.count != 0
    @profile.append(Profile.find_by(id: x.followed_id))
  end
end
