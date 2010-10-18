class OauthController < ApplicationController
  def initialize
  end

  def default_callback_url
    url_for(:controller => 'oauth', :action => 'accept')
  end
    
  def accept
    access = OauthToken.find_by_user_id(current_user.id).authorize
    redirect_to '/'
  end

end
