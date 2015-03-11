class Corkboard::NotificationsController < ApplicationController

  layout 'corkboard'

  before_filter :verify_session

  def index
    # notifications = current_user.current_notifications.map do |notification|
    #   NotificationSerializer.new(notification).serializable_hash
    # end

    notifications = current_user.current_notifications

    @presenter = {
      notifications: notifications,
      activeTab:  'notifications'
    }
  end

  private

  def verify_session
    redirect_to corkboard_intro_path unless signed_in?
  end
end
