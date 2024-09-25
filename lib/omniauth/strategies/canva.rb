require 'omniauth/strategies/oauth2'
require 'securerandom'

module OmniAuth
  module Strategies
    class Canva < OmniAuth::Strategies::OAuth2
      option :name, :canva

      DEFAULT_SCOPE         = 'profile:read'
      DEFAULT_SITE          = 'https://www.canva.com'
      DEFAULT_AUTHORIZE_URL = '/api/oauth/authorize'
      DEFAULT_TOKEN_URL     = 'https://api.canva.com/rest/v1/oauth/token'
      DEFAULT_SKIP_INFO     = false
      IDENTITY_URL          = 'https://api.canva.com/rest/v1/users/me'
      PROFILE_URL           = 'https://api.canva.com/rest/v1/users/me/profile'

      option :client_options, {
        site:          DEFAULT_SITE,
        authorize_url: DEFAULT_AUTHORIZE_URL,
        token_url:     DEFAULT_TOKEN_URL,
        skip_info:     DEFAULT_SKIP_INFO
      }

      # You may specify that your strategy should use PKCE by setting
      # the pkce option to true: https://tools.ietf.org/html/rfc7636
      option :pkce, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      # For Canva, this ID is only present in the /me response
      # The display name is only present in the /me/profile response
      uid { raw_info['team_user']['user_id'] }

      info do
        {
          name: raw_info['profile']['display_name'],
          nickname: raw_info['profile']['display_name']
        }
      end

      extra do
        skip_info? ? { } : { 'raw_info' => raw_info }
      end

      # This joins the current user info (containing the user id) and 
      # the current user profile info (containing the display name)
      def raw_info
        @raw_info ||= access_token.get(IDENTITY_URL).parsed.merge(access_token.get(PROFILE_URL).parsed)
      end

      # This takes care of stripping out the origin= query parameter, which
      # is needed to have Canva accept this redirect URL. The value of the 
      # origin parameter is stored in the omniauth.origin session.
      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end
    end
  end
end
