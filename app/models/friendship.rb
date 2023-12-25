# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :followed, class_name: 'Profile'
  belongs_to :follower, class_name: 'Profile'
end
