class OauthController < ApplicationController

  def default_callback_url site
    URI.encode url_for(:controller => 'oauth', :action => 'accept')
  end
    
  def accept
    record = OauthToken.find_by_user_id_and_request_key(current_user.id, params[:oauth_token])

    access = record.authorize params[:oauth_verifier]
    redirect_to (session[:oauth_refers]||{})[record.site] || '/' 
  end

  def cancel
    record = OauthToken.where(:user_id => current_user.id, :site => params[:site]).first
    if record.destroy
      render :text => 'ok'
    else
      render :text => 'fail', :status => 500
    end
  end

  def cancel_all
    if OauthToken.where(:user_id => current_user.id).delete_all
	  render :text => 'ok'
	else
	  render :text => 'fail', :status => 500
	end
  end
end
