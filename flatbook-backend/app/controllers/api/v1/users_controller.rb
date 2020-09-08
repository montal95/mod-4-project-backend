class Api::V1::UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        render json: {id: @user.id, name: @user.name, email: @user.email}
    end

    def create
        new_user = Player.create(user_params)
        render json: {id: new_user.id, name: new_user.name, email: new_user.email}
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end

    def destroy
        user = User.find(params[:id])
        begin
            user.destroy
            render json: {message: 'success', status: 200}
        rescue
            render  json: {error: 'unable to delete'}
        end
    end

    private
    def user_params
        params.permit(:name, :email, :password)
    end
end
