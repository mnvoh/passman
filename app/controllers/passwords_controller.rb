class PasswordsController < ApplicationController
  include Security

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
  def destroy
    @password.destroy
    redirect_to passwords_url,
      notice: 'Password was successfully destroyed.'
  end

  def generator
    @length = (params[:length] || 12).to_i
    @lower = params[:lower] == 'true'
    @upper = params[:upper] == 'true'
    @numbers = params[:numbers] == 'true'
    @symbols = params[:symbols] == 'true'

    unless [@lower, @upper, @numbers, @symbols].any? { |c| c }
      @lower = @upper = @numbers = @symbols = true
    end

    @random_string = random(@length, @lower, @upper, @numbers, @symbols)
  end

  def generate
    length = (params[:length] || 12).to_i
    lowercase = params[:lower] == 'true'
    uppercase = params[:upper] == 'true'
    numbers = params[:numbers] == 'true'
    symbols = params[:symbols] == 'true'

    unless [lowercase, uppercase, numbers, symbols].any? { |a| a == true }
      render json: { error: 'At least one character set must be selected' },
        status: 400 and return
    end

    random_string = random(length, lowercase, uppercase, numbers, symbols) 

    render json: { random: random_string }
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
