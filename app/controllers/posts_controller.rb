# frozen_string_literal: true

class PostsController < ApplicationController
  include CurrentProfile
  include ProfilePicture
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(profile_id: current_profile))
    if @post.save
      @postcount = Post.all.count
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', partial: 'posts/post', locals: { post: @post }) }
        format.html { redirect_to profiles_path, notice: 'Post Created' }
      end
    else
      render :new, status: :unporocessable_entity
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @post.destroy
    respond_to(&:js)
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.update(edit_params)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("onePost-#{@post.id}", partial: 'posts/post', locals: { post: @post }) }
      format.html { redirect_to profiles_path, notice: 'Post Created' }
    end
  end

  def share
    post = Post.find_by(id:params[:id])
    share_post = post.dup
    share_post.update(comment_count:0,likes_count:0,profile_id:current_profile,shared:Profile.where(id:post.profile_id).pluck(:user_name),status:1,images:post.images_blobs)
  end

  def archives
    @archives = Post.where(archived:1)
    @current_profile = Profile.find_by(id:current_profile)
    @current_profile_picture = current_profile_picture
  end

  def archive_post
    Post.find_by(id:params[:id]).true!
    redirect_to profiles_path
  end

  def un_archive_post
    Post.find_by(id:params[:id]).false!
    redirect_to archives_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, :location, images: [])
  end

  def edit_params
    params.require(:post).permit(:caption, :location)
  end
end
