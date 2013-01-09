require 'spec_helper'
require 'rspec/mocks'
require 'rspec/mocks/standalone'

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
    let!(:event1) { FactoryGirl.create(:event, club: club, name: "Hot Night Disco", created_at: DateTime.new(2012, 10, 10, 11, 00, 00)) }
    let!(:event2) { FactoryGirl.create(:event, club: club, name: "Rock or die", created_at: DateTime.new(2012, 10, 8, 11, 00, 00)) }

    let!(:comment1) { FactoryGirl.create(:comment, event: event1, author: "Tom", content: "Bla Bla blaaa", 
                                            created_at: DateTime.new(2012, 10, 10, 11, 00, 00)) }
    let!(:comment2) { FactoryGirl.create(:comment, event: event1, author: "Jan", content: "BGruooo",
                                            created_at: DateTime.new(2012, 10, 10, 12, 00, 00)) }


    before(:each) do
      # ClubsController.stub!(:event_button?).and_return(false)
      visit city_club_path(city, club)
    end

    it { should have_selector('title', text: club.name) }   
    it { should have_content(club.address) } 

    describe "when event is not created" do
      # it { should have_link("Create event") }
    end
    
    describe "when event is already created" do
      it { should have_selector('h3', text: "Today's event") }   
      it { should have_content(event1.name) }
      it { should have_content(event1.description) }
      it { should have_link('Thumb up', href: thumbup_event_path(club, club.events.first)) }   
      it { should have_link('Thumb down', href: thumbdown_event_path(club, club.events.first)) }  
      it { should have_link('Comment') }  

      describe "voting yes" do
        let(:thumbup_count) { 0 }
        before { click_link "Thumb up" }

        it { should have_selector('div.alert.alert-success') }
        specify { event1.reload.thumbup.should == (thumbup_count + 1) }
      end 

      describe "voting no" do
        let(:thumbdown_count) { 0 }
        before { click_link "Thumb down" }

        it { should have_selector('div.alert.alert-success') }
        specify { event1.reload.thumbdown.should == (thumbdown_count + 1) }        
      end

      describe "voting yes or no with exception raised at updating" do
        before (:each) do
          Event.any_instance.stub(:update_attributes).and_return(false)
          click_link "Thumb down"
        end

        it { should have_selector('div.alert.alert-error') }
      end

      describe "clicking comment" do
        before { click_link "Comment" }

        it { should have_selector("div.modal.hide.fade") }
      end
    end

    describe "comments part" do
      let!(:comment1) { FactoryGirl.create(:comment, event: event1, author: "Tom", content: "Bla Bla blaaa", 
                                            created_at: DateTime.new(2012, 10, 10, 11, 00, 00)) }
      let!(:comment2) { FactoryGirl.create(:comment, event: event1, author: "Jan", content: "BGruooo",
                                            created_at: DateTime.new(2012, 10, 10, 12, 00, 00)) }

      
      it { should have_selector('h3', text: "Comments") }   
      it { should have_content(comment1.author) }
      it { should have_content(comment1.content) }
      # it { should have_content(comment1.content) }
    end
  end
end
