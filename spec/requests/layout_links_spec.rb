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

    click_link 'Sign up'
    page.should have_selector('title', :text => "Sign up")
  end

end