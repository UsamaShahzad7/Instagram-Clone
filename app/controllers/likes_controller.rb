# frozen_string_literal: true

class LikesController < ApplicationController

  def index
    @likes = Like.where(post_id: params[:post_id])
  end

  def like
    current_like = Like.where(post_id: params[:post_id]).where(email: current_account.email)
    profile_id = Post.find_by(id: params[:post_id])
    return if current_like.exists?

    @like = Like.new(post_id: params[:post_id], email: current_account.email)
    Like.increment_like(params[:post_id])
    @like.save
    respond_to do |format|
      format.json
    end
  end

  def un_like
    current_like = Like.where(post_id: params[:id]).where(email: current_account.email)
    profile_id = Post.find_by(id: params[:id])
    return unless current_like.exists?

    current_like.destroy_all
    Like.decrement_like(params[:id])
    respond_to do |format|
      format.json
    end
  end

end
