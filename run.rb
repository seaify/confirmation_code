lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'confirmation_code'

confirmation_code = ConfirmationCode.use :lianzhong, 'seaify', '67c86225'

ap confirmation_code

confirmation_code.upload 'https://passport.58.com/validatecode?temp=123i1knr04o'

