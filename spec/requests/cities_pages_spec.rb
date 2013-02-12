require 'spec_helper'

describe "Cities Pages" do
	subject { page }

  describe "page for adding new city" do
  	before { visit addcity_path }

    it { should have_selector('h2',    text: 'Add city') }
    it { should have_selector('title', text: 'Adding city') }
  end

  describe "adding city" do
    before { visit addcity_path }

    let(:submit) { "Add new city" }

    describe "with valid information" do
      before do
        fill_in "Name",    with: "Warsaw"
        fill_in "Country", with: "Poland"
      end

      it "should create new city" do
        expect { click_button submit }.to change(City, :count).by(1)
      end 
    end

    describe "with invalid information" do
      it "should not create new city" do
        expect { click_button submit }.not_to change(City, :count)        
      end
    end
  end

  describe "city show page" do
  	let(:city) { FactoryGirl.create(:city) }
    let!(:club1) { FactoryGirl.create(:club, city: city, name: "Fanaberia", address: "Traugutta 2", description: "Ok klub") }
    let!(:club2) { FactoryGirl.create(:club, city: city, name: "Lizard", address: "Piotrkowska 24", description: "Rock klub") }

    let!(:event1) { FactoryGirl.create(:event, club: club1, name: "Hot Night Disco", thumbup: 1) }
    let!(:event2) { FactoryGirl.create(:event, club: club2, name: "Rock or die", thumbdown: 0) }

    before { visit city_path(city) }

    it {should have_selector('h1', text: city.name) }
    it {should have_selector('title', text: city.name) }

    describe "clubs list" do
      it { should have_content(club1.name) }
      it { should have_content(club2.name) }
      it { should have_content(club1.address) }
      it { should have_content(club2.address) }
      it { should have_content(city.clubs.count) }
      it { should have_selector('span', text: "+1")}
      it { should have_selector('span', text: "-0")}
    end

    describe "link to club page" do
      it { should have_link(club1.name, href: city_club_path(city, club1)) } 
    end
  end
end
