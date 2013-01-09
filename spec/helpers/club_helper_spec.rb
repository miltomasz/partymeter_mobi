require 'spec_helper'

describe ClubsHelper do
  describe "displaying button for adding events" do
    let(:current_date) { DateTime.new(2012, 10, 10, 14, 50, 50) }
    
    context "event is nil (not created)" do
      before { @event = nil }

      it "should show button" do
        event_button?(@event, current_date).should == true
      end
    end	

    context "event is created after 6 am" do
      before do
        @event = Event.new
        @event.created_at = DateTime.new(2012, 10, 10, 11, 00, 00)
      end

      it "should not show button" do
        event_button?(@event, current_date).should == false
      end
    end

    context "event is created before 6 am" do
      before do
        @event = Event.new
        @event.created_at = DateTime.new(2012, 10, 10, 5, 00, 00)
      end

      it "should show button" do
        event_button?(@event, current_date).should == true
      end

      describe "current hour is also before 6 am" do
        current_date = DateTime.new(2012, 10, 10, 5, 30, 00)

        it "should not show button" do
          event_button?(@event, current_date).should == false
        end
      end
    end

    context "event is create one day ago" do
      before do
        @event = Event.new
        @event.created_at = DateTime.new(2012, 10, 10, 13, 30, 00).to_time.yesterday
      end
      
      it "should show button" do
        event_button?(@event, current_date).should == true
      end

      describe "hour of creation is before 6 am" do
        before { @event.created_at = DateTime.new(2012, 10, 10, 5, 30, 00).to_time.yesterday }

        it "should show button" do
          event_button?(@event, current_date).should == true
        end
      end

      describe "current hour is before 6 am" do
        current_date = DateTime.new(2012, 10, 10, 5, 30, 00)

        it "should not show button" do
          event_button?(@event, current_date).should == false
        end
      end
    end

    context "event is create three or more days ago" do
      before do
        @event = Event.new
        @event.created_at = DateTime.new(2012, 10, 7, 16, 30, 00).to_time
      end

      it "should show button" do
        event_button?(@event, current_date).should == true
      end

      describe "current hour is before 6 am" do
        current_date = DateTime.new(2012, 10, 10, 0, 30, 00)

        it "should not show button" do
          event_button?(@event, current_date).should == true
        end
      end
    end

    context "event is created in a previous year 1 day ago" do
      before do
        @event = Event.new
        @event.created_at = DateTime.new(2012, 12, 31, 16, 30, 00).to_time
      end

      context "current time is after 6 am" do
        let(:current_date) { DateTime.new(2013, 01, 01, 14, 50, 50) }

        it "should show button" do
          event_button?(@event, current_date).should == true
        end
      end

      context "current time is before 6 am" do
        let(:current_date) { DateTime.new(2013, 01, 01, 5, 50, 50) }

        it "should not show button" do
          event_button?(@event, current_date).should == false
        end
      end

      context "current time is after 6 am and event created before 6 am" do
        let(:current_date) { DateTime.new(2013, 01, 01, 6, 30, 50) }
        before { @event.created_at = DateTime.new(2012, 12, 31, 5, 30, 00).to_time }

        it "should show button" do
          event_button?(@event, current_date).should == true
        end
      end
    end

    context "event is created in a previous year more than 1 day ago" do
      before do
        @event = Event.new
        @event.created_at = DateTime.new(2012, 12, 30, 16, 30, 00).to_time
      end

      let(:current_date) { DateTime.new(2013, 01, 01, 14, 50, 50) }

      it "should show button" do
        event_button?(@event, current_date).should == true
      end
    end
  end
end