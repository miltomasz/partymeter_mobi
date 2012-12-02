class Event < ActiveRecord::Base
  attr_accessible :description, :event_date, :name, :thumbdown, :thumbup
  belongs_to :club
  
  validates :club_id, presence: true
  validates :name, presence: true, length: { maximum: 60 }
  validates :description, length: { maximum: 140 }

  default_scope order: 'events.created_at DESC'
end
