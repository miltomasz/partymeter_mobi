require 'spec_helper'

describe Club do

  let(:city) { FactoryGirl.create(:city) }

  before do
    @club = city.clubs.build(name: "Lodz Kaliska", address: "Piotrkowska 82", description: "Legendarny klub")
  end

  subject { @club }

  it { should respond_to(:name) }
  it { should respond_to(:city_id) }
  it { should respond_to(:description) }
  it { should respond_to(:city_id) }
  its(:city) { should == city }

  it { should respond_to(:events) }

  it { should be_valid }

  describe "when city_id is not present" do
    before { @club.city_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @club.name = " " }
    it { should_not be_valid }
  end

  describe "with description that is too long" do
    before { @club.description = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to city_id" do
      expect do
        Club.new(city_id: city.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "club associations" do
    before { @club.save }
    
    let!(:older_event) do 
      FactoryGirl.create(:event, club: @club, name: "Older", created_at: 1.day.ago)
    end
    let!(:newer_event) do
      FactoryGirl.create(:event, club: @club, name: "Newer", created_at: 1.hour.ago)
    end

    it "should have the right clubs in the right order" do
      @club.events.should == [newer_event, older_event]
    end

    it "should get the last added event" do
      @club.events.first == newer_event
    end
  end
end
