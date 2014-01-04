require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    
    it "should be successfull" do
      visit '/users/new'
      response.should be_success
    end

    it 'should have the right title' do
      visit '/users/new'
      page.should have_selector('title', :text => 'Sign up')
    end
    
  end

end
