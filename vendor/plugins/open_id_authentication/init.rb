if config.respond_to?(:gems)
  config.gem 'pelle-ruby-openid', :lib => 'openid', :version => '>=2.1.8', :source => 'http://gems.github.com'
else
  begin
    require 'openid'
  rescue LoadError
    begin
      gem 'pelle-ruby-openid', '>=2.1.8', :lib => 'openid'
    rescue Gem::LoadError
      puts "Install the ruby-openid gem to enable OpenID support"
    end
  end
end

config.to_prepare do
  OpenID::Util.logger = Rails.logger
  ActionController::Base.send :include, OpenIdAuthentication
end
