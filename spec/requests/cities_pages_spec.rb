require 'spec_helper'

describe "Cities Pages" do
	subject { page }

  describe "page for adding new city" do
  	before { visit addcity_path }

    it { should have_selector('h1',    text: 'Add city') }
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
    before { visit city_path(city) }

    it {should have_selector('h1', text: city.name) }
    it {should have_selector('title', text: city.name) }
  end
end
