class Club < ActiveRecord::Base
  attr_accessible :address, :description, :name

  validates :city_id, presence: true
  validates :name, presence: true
  validates :description, length: { maximum: 140 }

  belongs_to :city

  default_scope order: 'clubs.created_at DESC'
end
