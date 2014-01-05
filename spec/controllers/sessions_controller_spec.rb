require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it 'should have the right title' do
      visit sessions_new_path
      page.should have_selector('title', :text => 'Sign in')
    end
  end

end
