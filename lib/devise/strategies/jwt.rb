require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class JWT < Authenticatable
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        payload = ::JWT.decode(token, secret).first
        success! User.find(payload['sub'])
      rescue ::JWT::ExpiredSignature
        fail! 'Auth token has expired. Please login again'
      rescue ::JWT::DecodeError
        fail! 'Auth token is invalid'
      rescue StandardError
        fail!
      end

      private

      def token
        request.headers.fetch('Authorization', '').split(' ').last
      end

      def secret
        Rails.application.secrets.secret_key_base
      end
    end
  end
end
