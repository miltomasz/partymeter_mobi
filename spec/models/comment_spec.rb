require 'spec_helper'

describe Comment do
  let(:event) { FactoryGirl.create(:event) }
  before do
    @comment = event.comments.build(content: "Lorem ipsum", author: "Tomek")
  end

  subject { @comment }

  it { should respond_to(:author) }
  it { should respond_to(:content) }
  it { should respond_to(:event_id) }
  it { should respond_to(:event) }
  its(:event) { should == event }

  it { should be_valid }

  describe "when event_id is not present" do
    before { @comment.event_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @comment.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank author" do
    before { @comment.author = " " }
    it { should_not be_valid }
  end

  describe "with author that is too long" do
    before { @comment.author = "a" * 21 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to event_id" do
      expect do
        Comment.new(event_id: event.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
