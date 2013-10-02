class UserMessageWorker
  include Sidekiq::Worker

  def perform(message_id, user_id)
    message = Message.find(message_id)
    user = User.find(user_id)
    message.read_at = Time.now
    old_msg_count = user.messages.count

    if message.save
      msg_response_time = message.read_at - message.created_at

      response_rate = (user.messages.where("read_at IS NOT NULL").count)/(old_msg_count + 1)
      response_time = ((user.average_response_time * old_msg_count)+msg_response_time)/(old_msg_count + 1)
      user.update_attributes(:response_rate => response_rate, :average_response_time => average_response_time )
    end
  end
end