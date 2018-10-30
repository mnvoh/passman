class PasswordsController < ApplicationController
  before_action :set_password, only: [:show, :edit, :update, :destroy]

  # GET /passwords
  # GET /passwords.json
  def index
    @passwords = Password.all
  end

  # GET /passwords/1
  # GET /passwords/1.json
  def show
  end

  # GET /passwords/new
  def new
    @password = Password.new
  end

  # GET /passwords/1/edit
  def edit
  end

  # POST /passwords
  # POST /passwords.json
  def create
    @password = Password.new(password_params)

    respond_to do |format|
      if master_password_error == :weak
        @password.errors.add(:base, :master_password_weak)
        format.html { render :new }
      elsif master_password_error == :mismatch
        @password.errors.add(:base, :master_password_mismatch)
        format.html { render :new }
      else
        @password.encrypt_data(params[:master_password])
        if @password.save
          format.html {
            redirect_to @password,
            notice: 'Password was successfully created.'
          }
          format.json { render :show, status: :created, location: @password }
        else
          format.html { render :new }
          format.json {
            render json: @password.errors,
            status: :unprocessable_entity
          }
        end
      end
    end
  end

  # PATCH/PUT /passwords/1
  # PATCH/PUT /passwords/1.json
  def update
    respond_to do |format|
      if @password.update(password_params)
        format.html {
          redirect_to @password,
          notice: 'Password was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @password }
      else
        format.html { render :edit }
        format.json {
          render json: @password.errors,
          status: :unprocessable_entity
        }
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
end
