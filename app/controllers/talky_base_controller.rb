class TalkyBaseController < ApplicationController
  before_filter :authorized_only, except: [:index, :show]
  before_filter :authorize_resource

  private

  def authorized_only
    return if logged_in?
    flash[:notice] = t(:authorization_required)
    redirect_to login_path
  end

  def authorize_resource
    Rails.logger.info "==Auth== #{params[:action].to_sym}, #{resource.inspect}"
    authorize! params[:action].to_sym, resource, message: t("flash.#{params[:controller]}.access_denied")
  end
end
