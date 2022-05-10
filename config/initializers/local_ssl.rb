if Rails.env.development?
  # Puma-Dev SSL certificate is not trusted by Ruby HTTP libraries
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  OpenIDConnect.http_config do |config|
    config.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end