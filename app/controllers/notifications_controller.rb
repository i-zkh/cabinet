class NotificationsController < ApplicationController

  def new
  end

  def create
    PostRequest.notification(params[:body], current_user.id)
    redirect_to notifications_path, notice: 'Уведомление отправлено'
  end

  def index
    @notifications = GetRequest.notifications_by_vendor(current_user.id)
  end

end
