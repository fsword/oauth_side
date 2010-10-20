require 'oauth_side/ext/hash'
require 'oauth_controller'
require 'oauth_token'
require 'oauth_side/model'

Rails.oauth.each_pair{|site,props|
  OauthController.class_eval <<-EOF
    def #{site.to_s}
      begin
        auth_url = OauthToken.request_by(current_user.id,'#{site.to_s}')
        if auth_url =~ /&oauth_callback/
          redirect_to auth_url
        else
          redirect_to auth_url + "&oauth_callback=" + default_callback_url('#{site.to_s}')
        end
      end
    end
  EOF
}
