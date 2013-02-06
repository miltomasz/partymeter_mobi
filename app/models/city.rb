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

  has_many :clubs, dependent: :destroy, include: :events

  def sorted_clubs
    clubs.sort! do |club1, club2|
      if club1.events.first.nil?
        club1.events.build(thumbup: 0)
      end

      if club2.events.first.nil?
        club2.events.build(thumbup: 0)
      end

      if club1.events.first.thumbup.nil?
        club1.events.first.thumbup = 0
      end

      if club2.events.first.thumbup.nil?
        club2.events.first.thumbup = 0
      end
        
      club2.events.first.thumbup <=> club1.events.first.thumbup
    end
  end
end
