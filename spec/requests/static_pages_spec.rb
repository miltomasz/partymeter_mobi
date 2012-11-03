require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Partymeter App" }
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
  end

  describe "Home Page" do
    before { visit root_path }
    let(:heading)    { base_title }
    let(:page_title) { '' }

    it { should_not have_selector('title', :text => full_title('Home')) }

    describe "content" do
      it { should have_selector('h1',    text: 'All cities') }

      before(:all) { 10.times { FactoryGirl.create(:city) } }
      after(:all) { City.delete_all }

      it "should list each city" do
        City.paginate(page: 1).each do |city|
          page.should have_selector('li', text: city.name)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading)    { 'About Us' }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end
end
