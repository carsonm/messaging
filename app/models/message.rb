class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::FullTextSearch

  field :type
  field :user_id
  field :full_name
  field :content
  field :starred_for
  field :hidden_for

  belongs_to :conversation
  embeds_many :labels

  fulltext_search_in :full_name, :content
end