class Club < ActiveRecord::Base
  attr_accessible :address, :description, :name

  validates :city_id, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :description, length: { maximum: 140 }

  belongs_to :city
  has_many :events

  default_scope order: 'clubs.created_at DESC'
end
