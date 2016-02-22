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
    ap @username
    ap @password
    ap default_options
    @service
  end

  def upload(image_url, options = {})
    ap "in upload"
    ap default_options
    ap @service
    options = default_options.merge options
    ap options
    @service.upload image_url, options if @service
  end

  private

  def default_options
    {
        user_name:  @username,
        user_pw:  @password
    }
  end

end