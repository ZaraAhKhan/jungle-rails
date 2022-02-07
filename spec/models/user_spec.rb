require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User validations" do
    it "password and password_confirmation fields should match" do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:'belle@gmail.com',password:'12345',password_confirmation:'12345')
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it "cannot register if email is already registered" do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:'belle@gmail.com',password:'12345',password_confirmation:'12345')
      @user.save

      @user_another = User.new(first_name:'Beast',last_name:'LeBlanc', email:'belle@gmail.com',password:'12345',password_confirmation:'12345')
      @user_another.save

      expect(User.where(email:'belle@gmail.com').count).to eq(1)
    end

    it "cannot register if email is same" do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:'belle@gmail.COM',password:'12345',password_confirmation:'12345')
      @user.save

      @user_another = User.new(first_name:'Beast',last_name:'LeBlanc', email:'belle@gmail.com',password:'12345',password_confirmation:'12345')
      @user_another.save

      expect(User.where(email:'belle@gmail.COM').count).to eq(1)
    end

    it "should not register if first name is invalid" do
      @user = User.new(first_name:nil,last_name:'LeBlanc', email:'belle@gmail.com',password:'123',password_confirmation:'123')
      @user.save

      expect(User.where(email:'belle@gmail.com').count).to eq(0)
    end

    it "should not register if last name is invalid" do
      @user = User.new(first_name:'Belle',last_name:nil, email:'belle@gmail.com',password:'123',password_confirmation:'123')
      @user.save

      expect(User.where(email:'belle@gmail.com').count).to eq(0)
    end

    it "should not register if email is invalid" do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:nil,password:'123',password_confirmation:'123')
      @user.save

      expect(User.where(first_name:'Belle').count).to eq(0)
    end

    it "should not register if password is less than five characters" do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:nil,password:'123',password_confirmation:'123')
      @user.save

      expect(User.where(first_name:'Belle').count).to eq(0)
    end

    it "should  register if password is more than five characters" do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:'belle@gmail.com',password:'12345',password_confirmation:'12345')
      @user.save

      expect(User.where(first_name:'Belle').count).to eq(1)
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate users if email and password match' do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:'belle@gmail.com',password:'12345',password_confirmation:'12345')
      @user.save

      expect(User.authenticate_with_credentials('belle@gmail.com','12345')).to eq(@user)
      expect(User.authenticate_with_credentials('belle@gmail.com','1234')).to eq(nil)
      expect(User.authenticate_with_credentials('bell@gmail.com','12345')).to eq(nil)
    end

    it 'should authenticate users if email even if it has blank spaces' do
      @user = User.new(first_name:'Belle',last_name:'LeBlanc', email:'belle@gmail.com',password:'12345',password_confirmation:'12345')

      @user.save

      expect(User.authenticate_with_credentials(' belle@gmail.com ','12345')).to eq(@user)
      
    end

  end

end
