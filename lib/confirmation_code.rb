Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/confirmation_code/service/*.rb").sort.each do |f|
  require f.match(/(confirmation_code\/service\/.*)\.rb$/)[0]
end

module ConfirmationCode
  extend self

  attr_reader :username, :password

  def use(service, username, password)
    @service = ConfirmationCode::Service.const_get("#{service.to_s.capitalize}")
    @username = username
    @password = password
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