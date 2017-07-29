require 'spec_helper'
require 'interfaces/web/user/users_controller'

describe Interfaces::Web::User::UsersController, type: :controller do
  describe '#index' do
    before { create(:user, name: 'Talysson', email: 't@example.com') }

    it 'returns the users' do
      get '/'

      expect(json.size).to eq 1

      expect(json[0]).to include(
        'id' => a_kind_of(Integer),
        'name' => 'Talysson',
        'email' => 't@example.com'
      )
    end
  end

  describe '#create' do
    it 'creates a user and returns it' do
      post '/', name: 'Me', email: 'me@email.com'

      expect(json).to include(
        'id' => a_kind_of(Integer),
        'name' => 'Me',
        'email' => 'me@email.com'
      )
    end
  end

  describe '#show' do
    context 'when user exists' do
      it 'returns the user' do
        user = create(:user, name: 'User', email: 'user@example.com')

        get "/#{user.id}"

        expect(json).to include(
          'id' => user.id,
          'name' => 'User',
          'email' => 'user@example.com'
        )
      end
    end

    context 'when user does not exist' do
      it 'returns the user' do
        get '/0'

        expect(json).to eq(
          'error' => 'User with id 0 not found'
        )
      end
    end
  end
end
