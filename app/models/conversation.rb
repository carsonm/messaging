class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :users
  field :last_message
  field :last_from_previous_user
  field :hidden_for
  field :group_id
  field :starred_messages_for

  has_many :messages

  def list_display_message
    last_message = self.last_message if self.last_message
    last_message = self.last_from_previous_user if self.last_from_previous_user && last_message['user_id'] == CURRENT_USER.to_s
    return last_message
  end

  def to_list
    last_message = self.list_display_message
    conversation_users = self.users - [CURRENT_USER.to_s] - [last_message['user_id']]
    conversation_names = [last_message['user_id'] != CURRENT_USER.to_s ? User.find_by_id(last_message['user_id']).name.split(' ')[0] : nil].compact +
    conversation_users.collect { |user_id| User.find(user_id).name.split(' ')[0] } + ['me']
  end

  def message_to_list(message)
    conversation_users = self.users - [message.user_id] - [CURRENT_USER.to_s]

    message_to_list_display = message.full_name + ' to ' + conversation_users.collect { |user_id| User.find(user_id).name.split(' ')[0] }.join(', ')

    if conversation_users.length > 0 && message.user_id != CURRENT_USER.to_s
      message_to_list_display += ', me '
    elsif message.user_id != CURRENT_USER.to_s
      message_to_list_display += ' me '
    end

    return message_to_list_display
  end
end