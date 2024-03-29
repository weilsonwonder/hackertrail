class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  helper_method :current_acct

  protected
  def current_acct
    @current_acct = Account.find_by_token(session[:token])
  end
end
