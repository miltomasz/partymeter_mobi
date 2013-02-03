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

require 'spec_helper'

describe City do
  
  before { @city = City.new(name: "Warsaw", country: "Poland") }

  subject { @city }

  it { should respond_to(:name) }
  it { should respond_to(:country) }
  it { should respond_to(:clubs) }

  it { should be_valid }

  describe "when name is not present" do
    before { @city.name = " " }
    it { should_not be_valid }
  end

  describe "when country is not present" do
    before { @city.country = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @city.name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "when name and country are already taken" do
    before do
      city_with_same_name_and_country = @city.dup
      city_with_same_name_and_country.save
    end

    it { should_not be_valid }
  end

  describe "when country is the same but name differs" do
    before do
      city_with_same_name_and_country = @city.dup
      city_with_same_name_and_country.name = "Lodz"
      city_with_same_name_and_country.save
    end

    it { should be_valid }
  end

  describe "when name is the same but country differs" do
    before do
      city_with_same_name_and_country = @city.dup
      city_with_same_name_and_country.country = "Holland"
      city_with_same_name_and_country.save
    end

    it { should be_valid }
  end

  describe "clubs associations" do
    before { @city.save }

    let!(:club1) { FactoryGirl.create(:club, city: @city, created_at: 10.days.ago) }
    let!(:club2) { FactoryGirl.create(:club, city: @city, created_at: 10.days.ago) }

    let!(:event1) { FactoryGirl.create(:event, club: club1, thumbup: 10) }
    let!(:event2) { FactoryGirl.create(:event, club: club2, created_at: 2.days.ago, thumbup: 9) }
    let!(:event3) { FactoryGirl.create(:event, club: club2, created_at: 1.day.ago, thumbup: 11) }

    it "should have the right clubs in the right order" do
      @city.sorted_clubs.should == [club2, club1]
    end

    it "should destroy associated clubs" do
      clubs = @city.clubs.dup
      @city.destroy
      clubs.should_not be_empty
      clubs.each do |club|
        Club.find_by_id(club.id).should be_nil
      end
    end
  end
end
