# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Api::Application.initialize!

#maybe /usr/local/etc/openssl/cert.pem
#ENV['SSL_CERT_FILE'] = "/usr/local/Cellar/curl-ca-bundle/1.87/share/ca-bundle.crt"
#ENV['SSL_CERT_FILE']='/usr/local/etc/openssl/cert.pem'

