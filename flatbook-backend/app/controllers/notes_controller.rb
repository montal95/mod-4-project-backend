class NotesController < ApplicationController
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
end
