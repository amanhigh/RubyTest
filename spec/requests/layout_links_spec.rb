require 'spec_helper'

describe "LayoutLinks" do

  it 'should have right links in layout' do
    visit root_path
    page.should have_selector('title', :text => "Home")
    page.should have_selector('a[href="/"]>img[alt="Sample App"]')
    click_link 'About'
    page.should have_selector('title', :text => "About")
    click_link 'Contact'
    page.should have_selector('title', :text => "Contact")
    click_link 'Help'
    page.should have_selector('title', :text => "Help")
    click_link 'Home'
    click_link 'Sign up now!'
    page.should have_selector('title', :text => "Sign up")
  end

  describe "when not signed in" do
    it 'should have a signin link' do
      visit root_path
      page.should have_selector('a', :href => signin_path, :text => 'Sign in')
    end
  end

  describe "when signed in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button 'Sign in'
    end

    it 'should have a sign out link' do
      page.should have_selector('a', :href => signout_path, :text => 'Sign out')
    end

    it 'should have a profile link' do
      visit root_path
      page.should have_selector('a', :href => user_path(@user), :text => 'Profile')
    end

    it 'should have a settings link' do
      visit root_path
      page.should have_selector('a', :href => edit_user_path(@user), :text => 'Settings')
    end
  end
end