require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_url = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "should be successful" do
      visit '/'
      page.should have_content('Home')
    end

    it 'should have the right title' do
      visit '/'
      page.should have_selector('title', :text => "#{@base_url} | Home")
    end

    it 'should not have empty body' do
      visit '/home'
      page.body.should_not =~ /<body>\s*<\/body>/
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      visit '/contact'
      page.should have_content('Contact')
    end

    it 'should have the right title' do
      visit '/contact'
      page.should have_selector('title', :text => "#{@base_url} | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      visit '/about'
      page.should have_content('About')
    end

    it 'should have the right title' do
      visit '/about'
      page.should have_selector('title', :text => "#{@base_url} | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      visit '/about'
      page.should have_content('About')
    end

    it 'should have the right title' do
      visit '/about'
      page.should have_selector('title', :text => "#{@base_url} | About")
    end
  end

end
