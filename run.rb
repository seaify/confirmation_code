lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'confirmation_code'

ConfirmationCode.use :lianzhong, 'seaify', '67c86225'
ap ConfirmationCode.account

ConfirmationCode.use :damatu, 'seaify', 'lsm123', {app_key: '0f80784a5ff20d38df3977e461e3d82a', app_id: '41635'}
ap ConfirmationCode.account
ap ConfirmationCode.upload('http://captcha.qq.com/getimage')
#ap ConfirmationCode.upload('https://passport.58.com/validatecode?temp=123i1knr04o')

return
result = ConfirmationCode.upload 'https://passport.58.com/validatecode?temp=123i1knr04o'
ap result
ap ConfirmationCode.recognition_error result['data']['id']
ap ConfirmationCode.account

