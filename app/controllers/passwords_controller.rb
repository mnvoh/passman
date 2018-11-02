class PasswordsController < ApplicationController
  before_action :set_password, only: [:unlock, :show, :edit, :update, :destroy]

  def index
    @passwords = Password.all
  end

  def unlock
  end

  def show
    @master_password = params[:master_password]
    @decrypted_data = @password.decrypt_data(@master_password)
    if @decrypted_data.any? { |item| item.nil? }
      flash[:notice] = I18n.t('invalid_master_password')
      redirect_to unlock_password_path(@password)
    end
  end

  # GET /passwords/new
  def new
    @password = Password.new
  end

  # POST /passwords/1/edit
  def edit
    @master_password = params[:master_password] || session[:master_password]

    if @master_password.nil? || @master_password.empty?
      redirect_to unlock_password_path(@password)
      return
    end

    session[:master_password] = nil
    decrypt_data(@master_password)
  end

  # POST /passwords
  # POST /passwords.json
  def create
    @password = Password.new(password_params)

    if master_password_error == :weak
      @password.errors.add(:base, :master_password_weak)
      render :new
    elsif master_password_error == :mismatch
      @password.errors.add(:base, :master_password_mismatch)
      render :new
    else
      @password.encrypt_data(params[:master_password])
      if @password.save
        redirect_to @password, notice: 'Password was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /passwords/1
  def update
    if master_password_error == :weak
      flash[:alert] = I18n.t('master_password_weak')
      session[:master_password] = params[:old_master_password]
      redirect_to edit_password_path(@password)
    elsif master_password_error == :mismatch
      flash[:alert] = I18n.t('master_password_mismatch')
      session[:master_password] = params[:old_master_password]
      redirect_to edit_password_path(@password)
    else
      @password.title = params[:password][:title]
      @password.url = params[:password][:url]
      @password.password = params[:password][:password]
      @password.description = params[:password][:description]
      @password.encrypt_data(params[:master_password])

      if @password.save
        redirect_to @password, notice: 'Password was successfully updated.'
      else
        flash[:alert] = password.errors
        session[:master_password] = params[:old_master_password]
        redirect_to edit_password_path(@password)
      end
    end
  end

  # DELETE /passwords/1
  # DELETE /passwords/1.json
  def destroy
    @password.destroy
    respond_to do |format|
      format.html {
        redirect_to passwords_url,
        notice: 'Password was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  private

    def set_password
      @password = Password.find(params[:id])
    end

    def password_params
      params.require(:password).permit(
        :title,
        :url,
        :password,
        :description,
      )
    end

    def master_password_error
      master = params[:master_password]
      repeat = params[:repeat_master_password]
      puts "--- #{master} --- #{repeat} ---"

      if master.length < 6
        :weak
      elsif master != repeat
        :mismatch
      else
        :ok
      end
    end

    def decrypt_data(master_password)
      if @password.nil?
        return
      end

      decrypted_data = @password.decrypt_data(master_password)

      if decrypted_data.any? { |item| item.nil? }
        flash[:notice] = I18n.t('invalid_master_password')
        redirect_to unlock_password_path(@password)
        return
      end

      @password.password = decrypted_data[0]
      @password.description = decrypted_data[1]
    end
end
