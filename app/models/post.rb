# frozen_string_literal: true

class Post < ApplicationRecord

  enum archived: { true: 1 ,false: 0 }
  enum status: { shared: 1, shared_not: 0}

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many_attached :images

end
