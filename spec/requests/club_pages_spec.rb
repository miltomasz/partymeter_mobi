require 'spec_helper'

describe "ClubPages" do
  
  subject { page }
  let(:city) { FactoryGirl.create(:city) }

  describe "club creation" do
    before { visit city_clubs_path(city) }

    it { should have_link('Add club', href: new_city_club_path(city)) }  	

    describe "getting new club form" do
      before { click_link "Add club" }

      it { should have_selector('h1', text: 'Add club') }
      it { should have_button('Add new club') }

      describe "try to create with invalid information" do
        describe "when no information is given" do
          it "should not create a club" do
             expect { click_button "Add new club" }.not_to change(Club, :count)
          end
        end

        describe "when only name is given" do
          before { fill_in 'club_name', with: "Some club" }
          it "should not create a club" do
             expect { click_button "Add new club" }.not_to change(Club, :count)
          end
        end

        describe "error messages" do
          before { click_button "Add new club" }
          it { should have_content("Name can't be blank") } 
        end
      end

      describe "creation with valid information" do
        before { fill_in 'club_name', with: "Some club" }
        before { fill_in 'club_address', with: "Ulicowska 4/3" }
        it "should create a club" do
          expect { click_button "Add new club" }.to change(Club, :count).by(1)
        end
      end
    end
  end

  describe "showing club page" do
    let!(:club) { FactoryGirl.create(:club, city: city, name: "Fanaberia", address: "Traugutta 2", description: "Ok klub") }
    let!(:event1) { FactoryGirl.create(:event, club: club, name: "Hot Night Disco") }
    let!(:event2) { FactoryGirl.create(:event, club: club, name: "Rock or die") }

    before { visit city_club_path(city, club) }

    it { should have_selector('title', text: club.name) }   
    it { should have_content(club.address) } 

    describe "header links content" do
      it { should have_link('Add event') }
    end 

    describe "events" do
      it { should have_content(event1.name) }
      it { should have_content(event2.name) }
      it { should have_content(club.events.count) }
    end

     describe "link to event page" do
      it { should have_link(event2.name, href: event_path(club, event2)) } 
    end
  end
end
