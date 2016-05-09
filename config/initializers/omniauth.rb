OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '864680857825-oq7ncqt1fahdhf7n462uj4bqn3lbv2ki.apps.googleusercontent.com', 'Dg4wGrfNOCp35WK4R4ATHpwP', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end