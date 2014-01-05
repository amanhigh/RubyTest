require 'spec_helper'

describe "FriendlyForwardings" do
  it 'should forward to requested page after sign in' do
    user = FactoryGirl.create(:user)
    visit edit_user_path(user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button 'Sign in'
    current_path.should == edit_user_path(user)
    visit signout_path
    visit signin_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button 'Sign in'
    current_path.should == user_path(user)
  end
end