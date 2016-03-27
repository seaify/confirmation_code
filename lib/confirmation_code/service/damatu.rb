require 'awesome_print'
require 'open-uri'
require 'httpclient'
require 'json'
require 'digest/md5'

module ConfirmationCode
  module Service
    module Damatu

      extend self
      include ConfirmationCode

      HOST = 'http://api.dama2.com:7766'

      UPLOAD_URL = File.join(HOST, 'app/d2Url?')
      ACCOUNT_URL = File.join(HOST, 'app/d2Balance?')
      RECOGNITION_ERROR_URL = File.join(HOST, 'app/d2ReportError?')

      attr_reader :app_key

      def set_app_key(app_key)
        @app_key = app_key
      end

      def client
        @client ||= HTTPClient.new
      end

      def md5(value)
        return Digest::MD5.hexdigest(value)
      end

      def get_pwd(user, pwd)
        return md5(@app_key + md5(md5(user) + md5(pwd)))
      end

      def sign(options)
        return 'xx'
      end

      def upload(image_url, options = {})
        File.open("code.jpeg", "wb") do |f|
          f.write open(image_url).read
        end
        options = lianzhong_options.merge options
        File.open('code.jpeg') do |file|
          options['upload'] = file
          response = client.post(UPLOAD_URL, options)
          JSON.parse(response.body)
        end
      end

      def account(options = {})
        options = damatu_options.merge options
        ap options
        ap get_pwd(options[:user_name], options[:user_pw])
        response = client.get(ACCOUNT_URL, options)
        JSON.parse(response.body)
      end

      def recognition_error(options = {})
        response = client.post(RECOGNITION_ERROR_URL, options)
        JSON.parse(response.body)
      end

      def damatu_options
        {
            appID:  '41635',
        }
      end
    end

  end
end