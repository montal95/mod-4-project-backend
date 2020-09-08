class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find(params[:id])
        render json: @user
    end

    def create
        new_user = Player.create(user_params)
        render json: new_user
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
        params.permit(:name, :email)
    end
end
