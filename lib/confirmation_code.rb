Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/confirmation_code/service/*.rb").sort.each do |f|
  require f.match(/(confirmation_code\/service\/.*)\.rb$/)[0]
end

require 'httpclient'

module ConfirmationCode
  extend self

  attr_reader :username, :password

  def use(service, username, password, options = {})
    @service = ConfirmationCode::Service.const_get("#{service.to_s.capitalize}")
    @service.set_extra_options(options)
    @username = username
    @password = password
    @service
  end

  def upload(image_url, options = {})
    options = default_options.merge options
    @service.upload image_url, options if @service
  end

  def account
    @service.account default_options if @service
  end

  def recognition_error(yzm_id, options = {})
    options['yzm_id'] = yzm_id
    options = default_options.merge options
    @service.recognition_error options if @service
  end

  private

  def default_options
    {
        user_name:  @username,
        user_pw:  @password,
    }
  end

end