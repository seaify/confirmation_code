require 'awesome_print'
require 'excon'
require "open-uri"
require 'httpclient'

module ConfirmationCode
  module Service
    module Lianzhong

      extend self

      UPLOAD_URL = 'http://bbb4.hyslt.com/api.php?mod=php&act=upload'
      ACCOUNT_URL = 'http://bbb4.hyslt.com/api.php?mod=php&act=point'
      RECOGNITION_ERROR_URL = 'http://bbb4.hyslt.com/api.php?mod=php&act=error'

      def upload(image_url, options = {})
        ap options

        File.open("code.jpeg", "wb") do |f|
          f.write open(image_url).read
        end

        options = default_options.merge options
        ap options
        client = HTTPClient.new
        File.open('code.jpeg') do |file|
          options['upload'] = file
          response = client.post(UPLOAD_URL, options)
          ap response.body
          ap response.status
        end

      end

      def account

      end

      def recognition_error

      end

      def default_options
        {
            yzm_minlen:  '4',
            yzm_maxlen: '6',
            yzmtype_mark: '',
            zztool_token: '',
        }
      end
    end

  end
end