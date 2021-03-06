require 'spec_helper'

describe "Comment pages" do

	subject { page }

  let(:city) { FactoryGirl.create(:city) }
	let!(:club) { FactoryGirl.create(:club, city: city, name: "Fanaberia", address: "Traugutta 2", description: "Ok klub") }
  let!(:event) { FactoryGirl.create(:event, club: club, name: "Hot Night Disco", created_at: DateTime.new(2012, 10, 10, 11, 00, 00)) }

	describe "comments creation" do
    before do 
    	visit new_comment_path(event_id: event.id)
    end

    it { should have_selector('h3', text: 'Add comment') }
    it { should have_button('Add comment') }
    it { should have_link('Close') }

    describe "with invalid information" do
      it "should not create a comment" do
        expect { click_button "Add comment" }.not_to change(Comment, :count)
      end

      describe "error messages" do
        before { click_button "Add comment" }
        it { should have_content("Author can't be blank") } 
        it { should have_content("Content can't be blank") } 
      end
    end

    describe "with valid information" do
      before do
        fill_in 'comment_author', with: "Jan"
        fill_in 'comment_content', with: "Lorem ipsum"
        find(:xpath, "//input[@id='comment_event_id']").set(event.id)
      end

      it "should create a comment" do
        expect { click_button "Add comment" }.to change(Comment, :count).by(1)
      end
    end
	end
end
