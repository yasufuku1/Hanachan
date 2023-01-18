class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications
    # まだ確認していない通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
