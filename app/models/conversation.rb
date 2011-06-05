class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :users
  field :last_message
  field :last_from_previous_user
  field :hidden_for
  field :group_id

  has_many :messages
end