require 'spec_helper'

describe "EventPages" do

  subject { page }

  let(:city) { FactoryGirl.create(:city) }
  let(:club) { FactoryGirl.create(:club, city: city, name: "Fanaberia", address: "Traugutta 2", description: "Ok klub") }
  let(:event) { FactoryGirl.create(:event, club: club, name: "Hot Night Disco") }

  describe "event creation" do
    before { visit city_club_path(city, club) }

    it { should have_link('Create event', href: new_event_path(club)) }  	

    describe "getting new event form" do
      before { click_link "Create event" }
      
      it { should have_selector('h1', text: 'Add event') }
      it { should have_button('Add new event') }

      describe "try to create with invalid information" do
        it "should not create an event" do
          expect { click_button "Add new event" }.not_to change(Event, :count)
        end

        describe "error messages" do
          before { click_button "Add new event" }
          it { should have_content("Name can't be blank") } 
        end
      end

      describe "creation with valid information" do
        before { fill_in 'event_name', with: "Some cool event" }
        it "should create an event" do
          expect { click_button "Add new event" }.to change(Event, :count).by(1)
        end
      end
    end
  end

  describe "showing event page" do
    let(:club) { FactoryGirl.create(:club, city: city, name: "Enklawa", address: "Mazowiecka 3", description: "Ok klub") }
    let(:event1) { FactoryGirl.create(:event, club: club, name: "Hot Night Disco") }

    before { visit event_path(club, event1) }

    it { should have_selector('title', text: event1.name) }   
    it { should have_content(event1.description) } 
  end
end
