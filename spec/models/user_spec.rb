
require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end

## Required Field Validator
#------------------------------------
describe User do

  @user = User.new(name: "Example User", email: "user@example.com",
                   password: "foobar", password_confirmation: "foobar")

 subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

 it { should be_valid }
end


describe "when name will be not present" do
   before { @user.name = ""}
   it { should_not be_valid }
 end
 
 describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

describe "when password is not present" do
  before { @user.password = " " }
  it { should_not be_valid }
end


  #Length Validation
  #-------------------------------------------------
   describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
   end

#password Length
#--------------------------------------




  # Email Validation
  #---------------------------------------
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  #Unique Email
  #--------------------------------------------
  describe "when email address is already taken" do
       it { should_not be_valid }
end


  #password and confirmation password Matching
  #--------------------------------------------------
describe "when password is not present" do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: " ", password_confirmation: " ")
  end
  it { should_not be_valid }
end
describe "when password doesn't match confirmation" do
  before { @user.password_confirmation = "mismatch" }
  it { should_not be_valid }
end



#Authenticate User
#---------------------------------
describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by(email: @user.email) }

  describe "with valid password" do
    it { should eq found_user.authenticate(@user.password) }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
  end
end

