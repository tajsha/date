Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1582975658618850", "56f31fa3d9e9cf60d599afa4981c1407", {:scope => 'user_about_me, publish_actions, manage_pages'}
end
