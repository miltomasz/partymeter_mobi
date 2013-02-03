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
  attr_accessible :country, :name

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :country }
  validates :country, presence: true

  has_many :clubs, dependent: :destroy

  def sorted_clubs
    clubs.sort do |c1, c2|
      unless c1.events.empty? || c2.events.empty?
        c2.events.first.thumbup <=> c1.events.first.thumbup
      else
        0
      end
    end
  end
end
