class Comment < ActiveRecord::Base
  attr_accessible :content, :author
  belongs_to :event

  validates :event_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :author, presence: true, length: { maximum: 20 }

  default_scope order: 'comments.created_at DESC'
end
