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
  it { should respond_to(:comments) }

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

  describe "comments associations" do
    before { @event.save }
    
    let!(:older_comment) do 
      FactoryGirl.create(:comment, event: @event, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, event: @event, created_at: 1.hour.ago)
    end

    it "should have the right comments in the right order" do
      @event.comments.should == [newer_comment, older_comment]
    end

    it "should destroy associated comments" do
      comments = @event.comments.dup
      @event.destroy
      comments.should_not be_empty
      comments.each do |comment|
        Comment.find_by_id(comment.id).should be_nil
      end
    end
  end
end
