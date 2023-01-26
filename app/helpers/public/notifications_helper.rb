module Public::NotificationsHelper

  # ログインしているユーザに未通知があるかどうか調べる
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
