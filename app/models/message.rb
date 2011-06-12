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
  embeds_many :message_labels

  fulltext_search_in :full_name, :content, :ngram_width => 0

  def starred
    self.starred_for && self.starred_for.include?(CURRENT_USER.to_s) ? "starred" : "unstarred"
  end

  def hide_starred(starred)
    hide_starred = ''
    hide_starred = 'hidden' if (starred == 'true') && (!self.starred_for || !self.starred_for.include?(CURRENT_USER.to_s))
    return hide_starred
  end

  def hidden
    self.hidden_for && self.hidden_for.include?(CURRENT_USER.to_s) ? "hidden_" : ""
  end

  def hidden?
    self.hidden_for && self.hidden_for.include?(CURRENT_USER.to_s) ? true : false
  end
end