class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods


  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @athorized = User.find_by(token: token)
    end
  end
end
