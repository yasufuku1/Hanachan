class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  def create_notification_follow!(current_user)
    # すでフォローの通知があるか?
    temp_id = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, followed_id, 'follow'])
    # 通知がなければ通知を作成
    if temp_id.blank?
      notification = current_user.active_notifications.new(
        visited_id: followed_id,
        action: 'follow'
      )
    notification.save if notification.valid?
    end
  end
end
