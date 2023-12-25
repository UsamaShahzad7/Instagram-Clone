# frozen_string_literal: true

class Comment < ApplicationRecord
  scope :increment_comment, ->(post) { Post.find_by(id: post).increment!(:comment_count, 1) }
end
