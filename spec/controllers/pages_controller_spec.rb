require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_url = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "should be successful" do
      visit '/pages/home'
      page.should have_content('Home')
    end

    it 'should have the right title' do
      visit '/pages/home'
      page.should have_selector('title', :text => "#{@base_url} | Home")
    end

    it 'should not have empty body' do
      visit '/pages/home'
      page.body.should_not =~ /<body>\s*<\/body>/
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      visit '/pages/contact'
      page.should have_content('Contact')
    end

    it 'should have the right title' do
      visit '/pages/contact'
      page.should have_selector('title', :text => "#{@base_url} | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      visit '/pages/about'
      page.should have_content('About')
    end

    it 'should have the right title' do
      visit '/pages/about'
      page.should have_selector('title', :text => "#{@base_url} | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      visit '/pages/help'
      page.should have_content('Help')
    end

    it 'should have the right title' do
      visit '/pages/help'
      page.should have_selector('title', :text => "#{@base_url} | Help")
    end
  end

end
