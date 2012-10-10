require 'spec_helper'

describe "Cities Pages" do
	subject { page }

  describe "page for adding new city" do
  	before { visit addcity_path }

    it { should have_selector('h1',    text: 'Add city') }
    it { should have_selector('title', text: 'Adding city') }
  end
end
