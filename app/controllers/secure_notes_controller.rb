class SecureNotesController < ApplicationController
  before_action :set_secure_note, only: [:unlock, :show, :edit, :update, :destroy]
  before_action :verify_login

  # GET /secure_notes
  def index
    @secure_notes = @current_user.secure_notes
  end

  def unlock
    @page_title = "Unlock #{@secure_note.title}"
  end

  # GET /secure_notes/1
  def show
    if @secure_note.user.id != @current_user.id
      head :forbidden
      return
    end
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
    @page_title = "Edit #{@secure_note.title}"
    @master_password = params[:master_password] || session[:master_password]
    puts "=" * 100
    puts @master_password
    puts "=" * 100

    if @master_password.nil? || @master_password.empty?
      redirect_to unlock_secure_note_path(@secure_note)
      return
    end

    session[:master_password] = nil
    decrypt_data(@master_password)
  end

  # POST /secure_notes
  def create
    @secure_note = SecureNote.new(secure_note_params)
    @secure_note.user = @current_user

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
    if master_password_error == :weak
      flash[:alert] = I18n.t('master_password_weak')
      session[:master_password] = params[:old_master_password]
      redirect_to edit_secure_note_path(@secure_note)
    elsif master_password_error == :mismatch
      flash[:alert] = I18n.t('master_password_mismatch')
      session[:master_password] = params[:old_master_password]
      redirect_to edit_secure_note_path(@secure_note)
    else
      @secure_note.title = params[:secure_note][:title]
      @secure_note.note = params[:secure_note][:note]
      @secure_note.encrypt_note(params[:master_password])

      if @secure_note.save
        redirect_to @secure_note, notice: 'Secure note was successfully updated.'
      else
        flash[:alert] = password.errors
        session[:master_password] = params[:old_master_password]
        redirect_to edit_secure_note_path(@secure_note)
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

    def decrypt_data(master_password)
      if @secure_note.nil?
        return
      end

      decrypted_note = @secure_note.decrypt_note(master_password)

      if decrypted_note.nil?
        flash[:notice] = I18n.t('invalid_master_password')
        redirect_to unlock_secure_note_path(@secure_note)
        return
      end

      @secure_note.note = decrypted_note
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
