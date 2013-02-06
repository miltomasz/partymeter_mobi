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
    checking_nil = lambda { |c| c.events.first.nil? || c.events.first.thumbup.nil? }

    clubs.sort! do |club1, club2|
      if checking_nil.call(club1) || checking_nil.call(club2)
        1
      else
        club2.events.first.thumbup <=> club1.events.first.thumbup
      end
    end
  end
end
