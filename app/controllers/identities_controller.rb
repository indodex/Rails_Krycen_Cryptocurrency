class IdentitiesController < ApplicationController
  before_filter :auth_anybody!, only: :new

  def new
    @identity = env['omniauth.identity'] || Identity.new
    redirect_to :back, alert: @identity.errors.full_messages.join(' <br/> ').html_safe
  end

  def edit
    @identity = current_user.identity
  end

  def update
    @identity = current_user.identity

    unless @identity.authenticate(params[:identity][:old_password])
      redirect_to edit_identity_path, alert: t('.auth-error') and return
    end

    if @identity.authenticate(params[:identity][:password])
      redirect_to edit_identity_path, alert: t('.auth-same') and return
    end

    if @identity.update_attributes(identity_params)
      current_user.send_password_changed_notification
      clear_all_sessions current_user.id
      reset_session
      redirect_to signin_path, notice: t('.notice')
    else
      render :edit
    end
  end

  def market_update
    @identity = current_user.identity

    unless @identity.authenticate(params[:identity][:old_password])
      render json: {status: 'failed', message: t('identities.update.auth-error')}, status: :ok and return
    end

    if @identity.authenticate(params[:identity][:password])
      render json: {status: 'failed', message: t('identities.update.auth-same')}, status: :ok and return
    end

    if @identity.update_attributes(identity_params)
      current_user.send_password_changed_notification
      clear_all_sessions current_user.id
      reset_session
      render json: {status: 'success', message: t('identities.update.notice')}, status: :ok
    else
      render json: {status: 'failed', message: 'failed'}, status: :ok
    end
  end

  private
  def identity_params
    params.required(:identity).permit(:password, :password_confirmation)
  end
end
