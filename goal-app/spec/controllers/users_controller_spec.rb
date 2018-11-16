require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user) { User.create!(username: 'username', password: 'password') }
  
  describe 'GET #index' do
    it 'renders the /users page' do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe 'GET #show' do
    it 'renders an individual user page' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end
  
  describe 'GET #new' do
    it 'renders the new user page' do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe 'GET #edit' do
    it 'renders the edit user page' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end
  
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        post :create, params: { user: { username: 'new_user', password: 'password' } }
        user = User.find_by(username: 'new_user')
        
        expect(user).not_to be_nil
        expect(response).to redirect_to(user_url(user))
      end
    end
    
    context 'with invalid params' do
      it 'does not create user renders new' do
        post :create, params: { user: { username: '', password: 'password' } }
        user = User.find_by(username: 'new_user')
        
        expect(user).to be_nil
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end
    
  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates user' do
        patch :update, params: { id: user.id, user: { username: 'updated_username', password: 'password' } }
        user = User.find_by(username: 'updated_username')
        
        expect(user).not_to be_nil
        expect(response).to redirect_to(user_url(user))
      end
    end
    
    context 'with invalid params' do
      it 'does not update user and renders the edit page again' do
        patch :update, params: { id: user.id, user: { username: '', password: 'password' } }
        user = User.find_by(username: '')
        
        expect(user).to be_nil
        expect(response).to render_template(:edit)
        expect(flash[:errors]).to be_present
      end
    end
  end
  
  describe 'DELETE #destroy' do
    it 'removes user from database' do
      delete :destroy, params: { id: user.id }
  
      expect { User.find(user.id) }.to raise_error
      expect(response).to redirect_to(new_user_url)
    end
  end
  
end