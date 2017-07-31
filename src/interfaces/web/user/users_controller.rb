require 'interfaces/web/base/controller'
require 'import'

module Interfaces
  module Web
    module User
      class UsersController < Web::Base::Controller
        include Import[
          'app.user.get_all_users',
          'app.user.get_user',
          'app.user.create_user'
        ]

        get '/' do
          get_all_users.call do |result|
            result.success do |users|
              body json(users.map(&:to_h))
            end

            result.error do |error|
              status 400
              body json(error)
            end
          end
        end

        get '/:id' do
          get_user.call(user_id: params.fetch(:id).to_i) do |result|
            result.success do |user|
              body json(user.to_h)
            end

            result.not_found do |error|
              status 404
              body json(error: "User with id #{params[:id]} not found")
            end
          end

        end

        post '/' do
          create_user.call(params) do |result|
            result.success do |user|
              status 201
              body json(user.to_h)
            end

            result.error do |error|
              status 400
              body json(error)
            end
          end
        end
      end
    end
  end
end
