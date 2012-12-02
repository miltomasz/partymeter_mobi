require 'spec_helper'

describe Event do
  let(:club) { FactoryGirl.create(:club) }
  before do
    @event = club.events.build(name: "Hot Night December", event_date: Date.new(2012, 11, 25), description: "Cool party!", 
    									 thumbup: 1, thumbdown: 1)
  end

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:event_date) }
  it { should respond_to(:description) }
  it { should respond_to(:thumbup) }
  it { should respond_to(:thumbdown) }
  it { should respond_to(:club_id) }

  it { should respond_to(:club) }
  its(:club) { should == club }

  it { should be_valid }

  describe "when club_id is not present" do
    before { @event.club_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @event.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @event.name = "a" * 61 }
    it { should_not be_valid }
  end

  describe "with description that is too long" do
    before { @event.description = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to club_id" do
      expect do
        Event.new(club_id: club.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
