class Api::V1::UsersController < ApplicationController
    def create
    @user = User.create(user_params)
        if @user.valid?
            payload = { id: @user.id}
            token = JWT.encode(payload, 'Secret', 'HS256')
            render json: { id: @user.id, email: @user.email, token: token }
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    private
    def user_params
        params.permit(:name, :email, :password)
    end
end
