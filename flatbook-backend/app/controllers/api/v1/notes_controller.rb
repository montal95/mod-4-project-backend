class Api::V1::NotesController < ApplicationController
    def index
        id = request.headers[:id]
        @notes = User.find(id).notes
        render json: @notes
    end

    def show
        note = Note.find(params[:id])
        render json: note.to_json(
            include:{
                user:{
                    only:%i[name email]
                }
            }
        )
    end

    def create
        user_id = request.headers[:id]
        user = User.find(user_id)
        note = user.notes.create(note_params)
        if note.valid?
            render json: note
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def update
        note = Note.find(params[:id])
        note.update(note_params)
        render json: note
    end

    def destroy
        note = Note.find(params[:id])
        begin
            note.destroy
            render json: { message: 'success', status: 200 }
        rescue
            render json: {error: 'unable to delete'}
        end
    end

    private
    def note_params
        params.permit(:title, :contents, :user_id)
    end
end
