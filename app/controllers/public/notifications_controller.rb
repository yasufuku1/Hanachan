class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications
  end

  def update
    @notifications = Notification.find(params[:id])
    # まだ確認していない通知のみ
    if @notifications.update(checked: true)
    redirect_to notifications_path
    end
  end

  def update_all
    # 全通知のcheckedをtrueにする
    @notifications = current_user.passive_notifications
    if @notifications.update_all(checked: true)
    redirect_to notifications_path
    end
  end
end
