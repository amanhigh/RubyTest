require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:name => 'Aman', :email => 'aman@aman.com'}
  end

  it 'should create a new user' do
    User.create!(@attr).should be_valid
  end

  it 'should require a name' do
    User.new(@attr.merge(:name => '')).should_not be_valid
  end

  it 'should require a email' do
    User.new(@attr.merge(:email => '')).should_not be_valid
  end

  it 'should reject long names' do
    long_name = 'a' * 51
    User.new(@attr.merge(:name => long_name)).should_not be_valid
  end

  it 'should accept valid emails' do
    addresses = %w[user@foo.com USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      User.new(@attr.merge(:email => address)).should be_valid
    end
  end

  it 'should not accept valid emails' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo]
    addresses.each do |address|
      User.new(@attr.merge(:email => address)).should_not be_valid
    end
  end

  it 'should reject duplicate emails' do
    User.create(@attr)
    User.new(@attr).should_not be_valid
  end

  it 'should reject duplicate upper case email address' do
    uppercase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => uppercase_email))
    User.new(@attr).should_not be_valid
  end
end
