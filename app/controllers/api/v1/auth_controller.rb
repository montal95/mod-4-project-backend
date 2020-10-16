class Api::V1::AuthController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            payload = { id: user.id}
            token = JWT.encode(payload, 'Secret', 'HS256')
            render json: { id: user.id, email: user.email, token: token }
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def show
        token = request.headers[:Authorization].split(' ').last
        decoded_token = JWT.decode(token, 'Secret', true, { algorithm: 'HS256'})
        user_id = decoded_token[0]['id']
        user = User.find(user_id)
        if user
            render json: { id: user.id, email: user.email, token: token }
        else
            render json: { error: 'Invalid token.' }
        end
    end
    

    private
    def user_params
        params.permit(:name, :email, :password)
    end
end