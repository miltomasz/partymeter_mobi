 class Event < ActiveRecord::Base
  attr_accessible :description, :event_date, :name, :thumbdown, :thumbup
  belongs_to :club
  has_many :comments, dependent: :destroy
  
  validates :club_id, presence: true
  validates :name, presence: true, length: { maximum: 60 }
  validates :description, length: { maximum: 140 }

  default_scope order: 'created_at desc'
  scope :last_event, order("created_at DESC").limit(1)
end
