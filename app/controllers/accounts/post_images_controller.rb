# frozen_string_literal: true

module Accounts
  class PostImagesController < ApplicationController
    before_action :set_profile

    def index
      respond_to :js
    end

    def destroy
      image = @profile.post_images.find_by(blob_id: params[:id])
      image.purge

      respond_to :js
    end

    private

    def set_profile
      @profile = current_user.profile
      redirect_to new_profile_url if @profile.nil?
    end
  end
end
