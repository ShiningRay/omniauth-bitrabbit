require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bitrabbit < OmniAuth::Strategies::OAuth2
      option :name, :bitrabbit
      include OmniAuth::Strategy
      option :client_options, {
               site: "https://account.bitrabbit.com",
               authorize_url: "/oauth/authorize"
             }

      def request_phase
        super
      end

      info do
        raw_info.merge("token" => access_token.token)
      end

      uid { raw_info["id"] }
      def raw_info
        @raw_info ||=
          access_token.get("/api/v1/me.json").parsed
      end
    end
  end
end