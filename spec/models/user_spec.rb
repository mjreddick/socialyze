require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'is invalid without an email address' do 
    user = FactoryGirl.build_stubbed(:user, email: nil)
    expect(user).to be_invalid
  end 

  it 'is invalid without a name' do
    user = FactoryGirl.build_stubbed(:user, name: nil)
    expect(user).to be_invalid
  end 

  it 'is invalid without a password_digest' do
    user = FactoryGirl.build_stubbed(:user, password_digest: nil)
    expect(user).to be_invalid
  end

  it {expect(subject).to respond_to(:authenticate)}


end
