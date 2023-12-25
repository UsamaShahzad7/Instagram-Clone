# frozen_string_literal: true

class Profile < ApplicationRecord

  enum status: { public_profile: 0, private_profile: 1 }

  has_one :archive, dependent: :destroy
  has_one_attached :profile_picture

  has_many :posts, dependent: :destroy
  has_many :followed_profiles, foreign_key: :followed_id, class_name: 'Friendship'
  has_many :followed, through: :followed_profiles, dependent: :destroy
  has_many :follower_profiles, foreign_key: :follower_id, class_name: 'Friendship'
  has_many :follower, through: :follower_profiles, dependent: :destroy

  scope :account_has_profile, ->(a) { where(account_id: a) }
  scope :following, ->(a) { Friendship.where(follower_id: a).pluck(:followed_id) }
  scope :followers, ->(a) { Friendship.where(followed_id: a).pluck(:follower_id) }
  scope :following_count, ->(a) { Friendship.where(follower_id: a).pluck(:followed_id).count }
  scope :followers_count, ->(a) { Friendship.where(followed_id: a).pluck(:follower_id).count }
  scope :max_followers, -> { Friendship.select(:followed_id).group(:followed_id).limit(10) }
  scope :post_count, ->(a) { Post.where(profile_id: a).count }
  scope :likes_count, ->(post) { Like.where(post_id: post).count }
  scope :comments_count, ->(post) { Comment.where(post_id: post).count }

end
