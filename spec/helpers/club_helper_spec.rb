require 'spec_helper'

describe ClubsHelper do
	describe "displaying button for adding events" do
    let(:current_date) { DateTime.new(2012, 10, 10, 14, 50, 50) }
    
    context "event is nil (not created)" do
    	before do 
    		@event = nil
    	end

      it "should show button" do
        event_button?(@event, current_date).should == true
      end
    end	

    context "event is created after 6 am" do
      before do
        @event = Event.new()
        @event.created_at = DateTime.new(2012, 10, 10, 11, 00, 00)
      end

      it "should not show button" do
        event_button?(@event, current_date).should == false
      end
    end

    context "event is created before 6 am" do
      before do
        @event = Event.new()
        @event.created_at = DateTime.new(2012, 10, 10, 5, 00, 00)
      end

      it "should show button" do
        event_button?(@event, current_date).should == true
      end

      describe "current date is also before 6 am" do
        current_date = DateTime.new(2012, 10, 10, 5, 30, 00)

        it "should not show button" do
          event_button?(@event, current_date).should == false
        end
      end
    end
	end
end