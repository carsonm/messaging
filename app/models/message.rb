class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :user_id
  field :full_name
  field :content
  field :starred_for
  field :hidden_for

  belongs_to :conversation
  embeds_many :labels
end