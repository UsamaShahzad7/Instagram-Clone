# frozen_string_literal: true

class Like < ApplicationRecord
  scope :increment_like, ->(post) { Post.find_by(id: post).increment!(:likes_count, 1) }
  scope :decrement_like, ->(post) { Post.find_by(id: post).decrement!(:likes_count, 1) }
end
