class SecureNotesController < ApplicationController
  before_action :set_secure_note, only: [:show, :edit, :update, :destroy]

  # GET /secure_notes
  # GET /secure_notes.json
  def index
    @secure_notes = SecureNote.all
  end

  # GET /secure_notes/1
  # GET /secure_notes/1.json
  def show
  end

  # GET /secure_notes/new
  def new
    @secure_note = SecureNote.new
  end

  # GET /secure_notes/1/edit
  def edit
  end

  # POST /secure_notes
  # POST /secure_notes.json
  def create
    @secure_note = SecureNote.new(secure_note_params)

    respond_to do |format|
      if @secure_note.save
        format.html { redirect_to @secure_note, notice: 'Secure note was successfully created.' }
        format.json { render :show, status: :created, location: @secure_note }
      else
        format.html { render :new }
        format.json { render json: @secure_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secure_notes/1
  # PATCH/PUT /secure_notes/1.json
  def update
    respond_to do |format|
      if @secure_note.update(secure_note_params)
        format.html { redirect_to @secure_note, notice: 'Secure note was successfully updated.' }
        format.json { render :show, status: :ok, location: @secure_note }
      else
        format.html { render :edit }
        format.json { render json: @secure_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secure_notes/1
  # DELETE /secure_notes/1.json
  def destroy
    @secure_note.destroy
    respond_to do |format|
      format.html { redirect_to secure_notes_url, notice: 'Secure note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secure_note
      @secure_note = SecureNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secure_note_params
      params.require(:secure_note).permit(:title, :iv, :salt, :password_strength)
    end
end
