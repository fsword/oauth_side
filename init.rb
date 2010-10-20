OAUTH_CONFIG = {:sites => {}, :model => nil }

Dir["#{Rails.root}/config/oauth/*.yml"].collect{|f|
  YAML.load_file(f).each_pair{|site,props|
    OAUTH_CONFIG[:sites].update(site.to_sym => {}) unless OAUTH_CONFIG[:sites].has_key? site.to_sym
    if props.class == Hash
      props.each_pair{|k,v|
	    OAUTH_CONFIG[:sites][site.to_sym].update(k.to_sym => v)
	  }
	end
  }
}

module Rails
  class << self
    def oauth
      OAUTH_CONFIG[:sites]
    end
    def oauth_model
      OAUTH_CONFIG[:model]
    end
    def oauth_model= model
      OAUTH_CONFIG[:model]=model
    end
  end
end


require 'oauth/consumer'
require 'oauth_side'
