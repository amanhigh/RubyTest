require 'spec_helper'

describe "LayoutLinks" do

  it 'should have a Home Page at /' do
    visit '/'
    page.should have_selector('title', :text => "Home")
  end

  it 'should have a Help Page at /help' do
    visit '/help'
    page.should have_selector('title', :text => "Help")
  end

  it 'should have a Contact Page at /contact' do
    visit '/contact'
    page.should have_selector('title', :text => "Contact")
  end

  it 'should have a About Page at /about' do
    visit '/about'
    page.should have_selector('title', :text => "About")
  end

end