class CampaignController < ApplicationController
  skip_before_action :authenticate_member!, only: [:index, :show]
  def index
    campaigns = Campaign.all
    respond_to do |format|
      format.json { render json: campaigns }
    end
  end

  def create
    campaign = current_user.campaigns.new campaign_params
    respond_to do |format|
      if campaign.save!
        format.json { render json: campaign }
      else
        format.json { render campaign.errors.full_messages.to_json, status: 400 }
      end
    end
  end

  def destroy
    campaign = Campaign.find(params[:id])
    if current_user.campaigns.include? campaign || current_admin
      campaign.delete
    end
  end

  def update
    campaign = Campaign.find(params[:id])
    respond_to do |format|
      if (current_user.campaigns.include? campaign || current_admin) && (campaign.update! campaign_params)
        format.json { render json: campaign }
      else
        format.json { render campaign.errors.full_messages.to_json, status: 400 }
      end
    end
  end

  def show
    campaign = Campaign.find(params[:id])
    respond_to do |format|
      format.json  { render :json => campaign.to_json(:methods => [:cover_photo_url, :description_photo_url, :profile_photo_url]) }
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :achieved, :goal,
                                     :video, :status, :profile_photo, :cover_photo, :description_photo)
  end
end
