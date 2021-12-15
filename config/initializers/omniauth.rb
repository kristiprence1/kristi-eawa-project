Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "680482515785-9a4iqklncl9vebf923hlm6kn122obsb3.apps.googleusercontent.com", "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", scope: 'userinfo.email,userinfo.profile', provider_ignores_state: true
end
OmniAuth.config.allowed_request_methods = %i[get]