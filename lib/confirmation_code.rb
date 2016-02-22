class ConfirmationCode
  attr_reader :username, :password

  def use(service, options)
    @service = ConfirmationCode::Service.const_get("#{service.to_s.capitalize}")
    @username = options[:username]
    @password = options[:password]
  end

  def upload(image_url, options = {})
    options = default_options.merge options
    @service.upload image_url, options if @service
  end

  def default_options
    {
        username:  @username,
        password:  @password
    }
  end

end