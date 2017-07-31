require 'spec_helper'
require 'interfaces/web/user/users_controller'

describe Interfaces::Web::User::UsersController, type: :controller do
  describe '#index' do
    let(:app) do
      get_all_users = double('get_all_users')
      allow(get_all_users).to receive(:call).and_yield(command_result)

      Interfaces::Web::User::UsersController.new(get_all_users: get_all_users)
    end

    context 'when no error occurs' do
      let(:command_result) do
        command_result = double('command_result')
        allow(command_result).to receive(:success).and_yield([
          { name: 'Talysson' }
        ])
        allow(command_result).to receive(:error)

        command_result
      end

      it 'returns status 200' do
        get '/'

        expect(response.status).to eq 200
      end

      it 'returns the users' do
        get '/'

        expect(json.size).to eq 1

        expect(json[0]).to include(
          'name' => 'Talysson',
        )
      end
    end

    context 'when an internal error occurs' do
      let(:command_result) do
        command_result = double('command_result')
        allow(command_result).to receive(:success)
        allow(command_result).to receive(:error).and_yield(StandardError.new('oops'))

        command_result
      end

      it 'returns status 400' do
        get '/'

        expect(response.status).to eq 400
      end

      it 'returns the users' do
        get '/'

        expect(json).to eq 'oops'
      end
    end
  end

  describe '#create' do
    let(:app) do
      create_user = double('create_user')
      allow(create_user).to receive(:call).with(name: 'Me').and_yield(command_result)

      Interfaces::Web::User::UsersController.new(create_user: create_user)
    end

    context 'when no error occurs' do
      let(:command_result) do
        command_result = double('command_result')
        allow(command_result).to receive(:success).and_yield({
          id: 123,
          name: 'Me'
        })
        allow(command_result).to receive(:error)

        command_result
      end

      it 'returns status 201' do
        post '/', name: 'Me'

        expect(response.status).to eq 201
      end

      it 'creates a user and returns it' do
        post '/', name: 'Me'

        expect(json).to include(
          'id' => 123,
          'name' => 'Me'
        )
      end
    end

    context 'when an internal error occurs' do
      let(:command_result) do
        command_result = double('command_result')
        allow(command_result).to receive(:success)
        allow(command_result).to receive(:error).and_yield(StandardError.new('oops'))

        command_result
      end

      it 'returns status 400' do
        post '/', name: 'Me'

        expect(response.status).to eq 400
      end

      it 'creates a user and returns it' do
        post '/', name: 'Me'

        expect(json).to eq 'oops'
      end
    end
  end

  describe '#show' do
    let(:app) do
      get_user = double('get_user')
      allow(get_user).to receive(:call).with(user_id: 123).and_yield(command_result)

      Interfaces::Web::User::UsersController.new(get_user: get_user)
    end

    context 'when user exists' do
      let(:command_result) do
        command_result = double('command_result')
        allow(command_result).to receive(:success).and_yield({
          name: 'Talysson'
        })
        allow(command_result).to receive(:not_found)

        command_result
      end

      it 'returns status 200' do
        get '/123'

        expect(response.status).to eq 200
      end

      it 'returns the user' do
        get '/123'

        expect(json).to eq(
          'name' => 'Talysson'
        )
      end
    end

    context 'when user does not exist' do
      let(:command_result) do
        command_result = double('command_result')
        allow(command_result).to receive(:success)
        allow(command_result).to receive(:not_found).and_yield(StandardError.new)

        command_result
      end

      it 'returns status 404' do
        get '/123'

        expect(response.status).to eq 404
      end

      it 'returns the user' do
        get '/123'

        expect(json).to eq(
          'error' => 'User with id 123 not found'
        )
      end
    end
  end
end
