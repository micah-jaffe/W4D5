# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:working_user2) { User.create!(username: 'peter', password: 'password') }
  
  describe 'testing validations' do
    
    it { should validate_presence_of :username }
    it { should validate_presence_of :password_digest }
    it { should validate_length_of(:password).is_at_least(6) }
    # debugger
    it { should validate_uniqueness_of(:username) }
    
    context 'testing session_token' do
      it 'assigns a session token if it does not have one already' do
        user = User.create(username: 'whatever', password: 'password')
        
        expect(user.session_token).not_to be_nil
      end
    end
  end
  
  describe 'password encryption' do
    it 'does not save password to database' do
      User.create(username: 'whatever', password: 'password')
      user = User.find_by(username: 'whatever')
      
      expect(user.password).not_to eq('password')
    end
  end
end
