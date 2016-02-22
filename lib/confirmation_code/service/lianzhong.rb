require 'awesome_print'
require 'excon'
require "open-uri"

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
        response = Excon.post(UPLOAD_URL, :body => URI.encode_www_form(options), :headers => { "Content-Type" => "multipart/form-data" })
        ap response
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