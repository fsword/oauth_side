class OauthController < ApplicationController
  def initialize
  end

  def default_callback_url site
    URI.encode url_for(:controller => 'oauth', :action => 'accept', :site => site)
  end
    
  def accept
    access = OauthToken.find_by_user_id_and_site(current_user.id, params[:site]).authorize
    redirect_to '/' #TODO 暂时返回网站主页
  end

end
