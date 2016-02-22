require 'awesome_print'
require 'excon'

module ConfirmationCode
  module Service
    module Lianzhong

      UPLOAD_URL = 'http://bbb4.hyslt.com/api.php?mod=php&act=upload'
      ACCOUNT_URL = 'http://bbb4.hyslt.com/api.php?mod=php&act=point'
      RECOGNITION_ERROR_URL = 'http://bbb4.hyslt.com/api.php?mod=php&act=error'

      def upload(image_url, options = {})
        image= Excon.post(UPLOAD_URL, :body => URI.encode_www_form(options), :headers => { "Content-Type" => "application/x-www-form-urlencoded" })
        options['upload'] = 'xx'
        response = Excon.post(UPLOAD_URL, :body => URI.encode_www_form(options), :headers => { "Content-Type" => "application/x-www-form-urlencoded" })
      end

      def account

      end

      def recognition_error

      end
    end

  end
end