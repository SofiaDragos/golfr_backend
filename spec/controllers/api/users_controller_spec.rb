require 'rails_helper'

describe Api::UsersController, type: :controller do
  describe 'POST login' do
    before :each do
      create(:user, name: 'User1', email: 'user@email.com', password: 'userpass')
    end

    it 'should return the token if valid username/password' do
      post :login, params: { email: 'user@email.com', password: 'userpass' }

      expect(response).to have_http_status(:ok)
      response_hash = JSON.parse(response.body)
      user_data = response_hash['user']

      expect(user_data['token']).to be_present
    end

    it 'should return an error if invalid username/password' do
      post :login, params: { email: 'invalid', password: 'user' }

      expect(response).to have_http_status(401)
    end
  end

  describe 'GET golfer name' do
    before :each do
      @user1 = create(:user, name: 'User1', email: 'user@email.com', password: 'userpass')
    end

    it 'should return the token if valid username/password' do
      get :user_name, params: { id: @user1.id }

      expect(response).to have_http_status(:ok)
      response_hash = JSON.parse(response.body)
      name = response_hash['name']

      expect(name).to eq @user1.name
    end
  end
end
