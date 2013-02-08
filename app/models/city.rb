# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ActiveRecord::Base
  include CityHelper
  
  attr_accessible :country, :name

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :country }
  validates :country, presence: true

  has_many :clubs, dependent: :destroy, include: :events
end
