require 'awesome_print'
require 'open-uri'
require 'httpclient'
require 'json'
require 'digest/md5'
require 'active_support/core_ext/hash'

module ConfirmationCode
  module Service
    module Damatu

      extend self
      include ConfirmationCode

      HOST = 'http://api.dama2.com:7766'

      UPLOAD_URL = File.join(HOST, 'app/d2Url?')
      ACCOUNT_URL = File.join(HOST, 'app/d2Balance?')
      RECOGNITION_ERROR_URL = File.join(HOST, 'app/d2ReportError?')

      attr_reader :app_key, :app_id
      @app_id = '41635'
      @app_key = '0f80784a5ff20d38df3977e461e3d82a'


      def set_extra_options(options)
        @app_key = options[:app_key]
        @app_id = options[:app_id]
      end

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
        ap md5(user)
        ap md5(pwd)
        ap md5(md5(user) + md5(pwd))
        return md5(@app_key + md5(md5(user) + md5(pwd)))
      end

      def sign(user, param = [])
        encode_str = (@app_key.bytes + user.bytes + param).pack('c*')
        return md5(encode_str)[0..7]
      end

      def upload(image_url, options = {})
        upload_options = damatu_options(options)
        upload_options['url'] = CGI::escape(image_url)
        upload_options['sign'] = sign(upload_options['user'], image_url.bytes)
        upload_options['type'] = 200 if upload_options['type'].nil?
        ap upload_options
        response = client.get(UPLOAD_URL, upload_options)
        result(JSON.parse(response.body))
      end

      def account(options = {})
        account_options = damatu_options(options)
        account_options['sign'] = sign(account_options['user'])
        response = client.get(ACCOUNT_URL, account_options)
        result(JSON.parse(response.body))
      end

      def recognition_error(options = {})
        response = client.post(RECOGNITION_ERROR_URL, options)
        JSON.parse(response.body)
      end

      def damatu_options(options)
        damatu_options = {}
        damatu_options['appID'] = @app_id
        damatu_options['user'] = options[:user_name]
        damatu_options['pwd'] = get_pwd(options[:user_name], options[:user_pw])
        damatu_options['type'] = options[:type] unless options[:type].nil?
        return damatu_options
      end

      def result(body)
        {
            success: body['ret'] == 0,
            code: body['ret'],
            data: body.except('ret', 'sign', 'cookie')
        }
      end
    end

  end
end