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

        it "should not create a club" do
          expect { click_button "Add new club" }.not_to change(Club, :count)
        end

        describe "error messages" do
          before { click_button "Add new club" }
          it { should have_content('error') } 
        end
      end

      describe "creation with valid information" do

        before { fill_in 'club_name', with: "Some club" }
        it "should create a club" do
          expect { click_button "Add new club" }.to change(Club, :count).by(1)
        end
      end

    end
  end
end