OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
   '553219461681-lf6qf9venvaqff3rlt16h6fpeiiiruua.apps.googleusercontent.com',
   'flIXsYdbKlnm_0VxQW4abEjI',
   {
     client_options:
     {
       ssl: { ca_file: Rails.root.join("cacert.pem").to_s}
      }
    }
end
