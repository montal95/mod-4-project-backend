class Api::V1::NotesController < ApplicationController
    def index
        @notes = Note.all
        options = {
            include:[:user]
        }
        render json: @notes.to_json(
            include:{
                user:{
                    only:%i[name email]
                }
            }
        )
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
        note = Note.create(note_params)
        render json: note
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
