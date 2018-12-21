class SecureNotesController < ApplicationController
  before_action :set_secure_note, only: [:unlock, :show, :edit, :update, :destroy]
  before_action :verify_login

  # GET /secure_notes
  def index
    @secure_notes = SecureNote.all
  end

  def unlock
    @page_title = "Unlock #{@secure_note.title}"
  end

  # GET /secure_notes/1
  def show
    @page_title = @secure_note.title
    @master_password = params[:master_password]
    @decrypted_note = @secure_note.decrypt_note(@master_password)
    if @decrypted_note.empty?
      flash[:notice] = I18n.t('invalid_master_password')
      redirect_to unlock_secure_note_path(@secure_note)
    end
  end

  # GET /secure_notes/new
  def new
    @page_title = I18n.t('new_secure_note')
    @secure_note = SecureNote.new
  end

  # GET /secure_notes/1/edit
  def edit
  end

  # POST /secure_notes
  def create
    @secure_note = SecureNote.new(secure_note_params)

    if master_password_error == :weak
      @secure_note.errors.add(:base, :master_password_weak)
      render :new
    elsif master_password_error == :mismatch
      @secure_note.errors.add(:base, :master_password_mismatch)
      render :new
    else
      @secure_note.encrypt_note(params[:master_password])
      if @secure_note.save
        redirect_to @secure_note, notice: 'Secure note was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /secure_notes/1
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
  def destroy
    @secure_note.destroy
    respond_to do |format|
      format.html { redirect_to secure_notes_url, notice: 'Secure note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_secure_note
      @secure_note = SecureNote.find(params[:id])
    end

    def secure_note_params
      params.require(:secure_note).permit(:title, :note)
    end

    def master_password_error
      master = params[:master_password]
      repeat = params[:repeat_master_password]

      if master.length < 6
        :weak
      elsif master != repeat
        :mismatch
      else
        :ok
      end
    end
end
