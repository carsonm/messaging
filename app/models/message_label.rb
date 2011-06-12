class MessageLabel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id
  field :label

  embedded_in :message
end