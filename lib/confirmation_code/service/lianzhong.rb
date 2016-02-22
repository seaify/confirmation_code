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

        options['upload'] = open(image_url).read
        options = default_options.merge options
        ap options
        c = HTTPClient.new
        boundary = "--1234567890"
        puts c.post_content(UPLOAD_URL, options,
                            "content-type" => "multipart/form-data, boundary=#{boundary}")
        #response = Excon.post(UPLOAD_URL, :body => options, :headers => { "Content-Type" => "multipart/form-data" })
        #ap response
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