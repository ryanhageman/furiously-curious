# frozen_string_literal: true

module Accounts
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile, only: %i[show edit update destroy]
    before_action :set_search
    after_action :verify_authorized, except: %i[index show]

    def index
      @profiles = requested_profiles
    end

    def show; end

    def new
      @profile = Profile.new
      authorize @profile
    end

    def create
      @profile = Profile.new(profile_params)
      @profile.user_id = current_user.id

      authorize @profile
      if @profile.save
        redirect_to accounts_profile_url(@profile), notice: "Here's your new Profile"
      else
        render :new, notice: "Your profile couldn't be saved."
      end
    end

    def edit
      authorize @profile
    end

    def update
      authorize @profile
      if @profile.update(profile_params)
        redirect_to accounts_profile_url(@profile), notice: 'Your profile has been updated.'
      else
        render :edit
      end
    end

    def destroy
      authorize @profile
      @profile.destroy

      redirect_to edit_user_registration_path
    end

    private

    def profile_params
      params.require(:profile).permit(
        :first_name, :last_name,
        :username, :bio, :user_id,
        :avatar, :delete_avatar,
        :post_images, post_images: []
      )
    end

    def set_search
      @search = params[:search]
    end

    def requested_profiles
      @search ? Profile.search_usernames(@search) : Profile.select(:username, :id)
    end

    def set_profile
      @profile = Profile.find(params[:id])
    end
  end
end
