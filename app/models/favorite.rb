class Favorite < ApplicationRecord
   belongs_to :user
   belongs_to :post

   def create_notification_like!(current_user)
   # すでいいねの通知があるか?
   temp_id = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, post.user_id, post.id, 'like'])

   # ない場合いいねの通知作成
      if temp_id.blank?
         notification = current_user.active_notifications.new(
            post_id: post.id,
            visited_id: post.user_id,
            action: 'like'
         )
      end
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
   end
end
