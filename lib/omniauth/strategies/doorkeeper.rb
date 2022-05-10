module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper

      option :client_options,
             site: "https://#{ENV['DOORKEEPER_PROVIDER_HOST']}",
             authorize_path: "/oauth/authorize"

      uid do
        raw_info["id"]
      end

      info do
        {
          email: raw_info["email"],
          first_name: raw_info["first_name"],
          last_name: raw_info["last_name"],
          role: raw_info["role"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/api/v1/me.json").parsed
      end
    end
  end
end