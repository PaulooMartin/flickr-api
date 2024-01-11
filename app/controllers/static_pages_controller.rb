class StaticPagesController < ApplicationController
  before_action :user_exists?, only: [:index]

  def index
    if params[:flickr_id]
      @user_photos = Flickr.new.people.getPhotosOf(user_id: params[:flickr_id])
    end
  end

  private

  def user_exists?
    return unless params[:flickr_id]

    begin
      Flickr.new.urls.getUserProfile(user_id: params[:flickr_id])
    rescue Flickr::FailedResponse => e
      # the problem with this is that it doesn't print pretty.
      redirect_to root_path, notice: e.message
    end
  end
end
