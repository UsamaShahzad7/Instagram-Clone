# frozen_string_literal: true

class ProfilesController < ApplicationController
  include CurrentProfile
  include ProfilePicture
  include AvatarCreator
  before_action :restrict_admin
  before_action :check_activation_status
  skip_before_action :authenticate_account!, only: %i[after_registration_path after_confirmation_path]
  skip_before_action :verify_authenticity_token, only: [:search]
  skip_before_action :check_activation_status, only: %i[after_registration_path after_confirmation_path]
  skip_before_action :restrict_admin, only: %i[after_registration_path after_confirmation_path]

  layout 'flow', only: [:new,:edit]

  def index
    if !Profile.account_has_profile(current_account.id).exists?
      redirect_to new_profile_path
    else
      @current_profile_picture = current_profile_picture
      @profile = Profile.find_by(account_id: current_account.id)
      @posts = Post.where(profile_id: current_profile).where(archived:0).order(created_at: :desc)
      @followers = Profile.followers_count(@profile.id)
      @following = Profile.following_count(@profile.id)
      @post_count = Profile.post_count(@profile.id)
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.update(email: current_account.email, account_id: current_account.id)
    if @profile.save
      name_creator unless @profile.profile_picture.representable?
      respond_to do |format|
        format.html { redirect_to profiles_path, notice: 'Post was successfully Created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @current_profile=Profile.find_by(id:current_profile)
    @current_profile_picture = current_profile_picture
    profile_id = params[:id]
    @profile = Profile.find_by(id: profile_id)
    @followers = Profile.followers_count(profile_id)
    @following = Profile.following_count(profile_id)
    @post_count = Profile.post_count(profile_id)
    follow_check = Friendship.where(follower_id: current_profile).where(followed_id: profile_id)
    followed_id = follow_check.pluck(:followed_id)
    @has_followed = if follow_check.empty?
                      0
                    elsif profile_id.to_i == followed_id[0]
                      1
                    else
                      0
                    end

    if profile_id.to_i == current_profile
      redirect_to profiles_path
    elsif @profile.public_profile?
      @posts = Post.where(profile_id:).order(created_at: :desc)
    elsif @profile.private_profile? && @has_followed == 1
      @posts = Post.where(profile_id:).order(created_at: :desc)
    else
      @message = 'This account is private'
    end
  end

  def edit
    @profile=Profile.find_by(id:params[:id])
  end

  def update
    @profile=Profile.find_by(id:params[:id])
    @profile.update(profile_params)
    @profile.update(email: current_account.email, account_id: current_account.id)
    @profile.update(status:0)
    if @profile.save

      name_creator unless @profile.profile_picture.representable?

      respond_to do |format|
        format.html { redirect_to profiles_path, notice: 'Post was successfully Created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def search
    @current_profile = Profile.find_by(id:current_profile)
    @current_profile_picture = current_profile_picture
    @result = if params[:searchQuery].include? '@'
                Profile.where("email LIKE ?",Profile.sanitize_sql_like("#{params[:searchQuery]}"))
              else
                Profile.where("user_name LIKE ?",Profile.sanitize_sql_like("%","#{params[:searchQuery].capitalize}"+"%"))
              end
  end

  def change_status
    profile = Profile.find_by(id:params[:profile_id])
    if profile.public_profile?
        profile.update(status:1)
        respond_to do |format|
          format.json {render json: profile}
        end
    else
      profile.update(status:0)
      respond_to do |format|
        format.json {render json: profile}
      end
    end
  end

  def after_registration_path
    render layout: 'flow'
  end

  def after_confirmation_path
    render layout: 'flow'
  end

  private

  def profile_params
    params.require(:profile).permit(:user_name, :profile_picture)
  end
end
