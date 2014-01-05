require 'spec_helper'

describe "Users" do
  describe "signup" do

    describe "failure" do
      it 'should not make a new user' do
        lambda do
          visit signup_path
          fill_in "Name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Sign up"
          current_path.should == users_path
          page.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it 'should make a new user' do
        lambda do
          visit signup_path
          fill_in "Name", :with => "Aman"
          fill_in "Email", :with => "aman@aman.com"
          fill_in "Password", :with => "password"
          fill_in "Confirmation", :with => "password"
          click_button "Sign up"
          page.should have_selector('div.flash.success', :text => "Welcome")
          #TODO:Check url and proper redirect
        end.should change(User, :count).by(1)
      end
    end

  end
end