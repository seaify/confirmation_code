# ConfirmationCode 验证码平台 Ruby 接口

## 支持以下打码平台

* [联众](https://www.jsdati.com/)
* [打码兔](http://www.dama2.com/)

还尝试过云打码, uusee, 挣码等,但都有一些问题,所以没有接入.

云打码: 使用样例，验证码类型设置为了1-6位，识别出来少了1位.  
uusee: api样例代码太复杂  
挣码: 给的http接口样例，域名都失效了    

尝试过的所有验证码平台, 官方网站+api都给人很不专业的感觉, 比云片网差太多了, 所以建议不要充值太多, 觉得也许容易跑路.

## 安装

加入以下代码到 Gemfile:

    gem 'confirmation_code'

然后执行:

    $ bundle

或者直接安装：

    $ gem install confirmation_code

## 使用

代码风格上参照了china_sms
```ruby
# 支持 :lianzhong, :damatu 验证码接口
ConfirmationCode.use :lianzhong, 'seaify', '67c86225'  
result = ConfirmationCode.upload('http://captcha.qq.com/getimage')

# 第一个参数验证码平台类型, 目前支持:lianzhong, :damatu, 第二个参数是用户名, 第三个参数是密码
ConfirmationCode.use :lianzhong, 'seaify', '67c86225'

# 上传图片url到打码平台
result = ConfirmationCode.upload('http://captcha.qq.com/getimage')

# 上传本地图片到打码平台
result = ConfirmationCode.upload('0349.bmp')

# 报告验证码识别结果有误
ap ConfirmationCode.recognition_error result['data']['id']
```

## 注意
示例中的用户名,密码是我的账号, 只充值了1块.

另外打码平台, 有软件分成的概念, 目前damatu默认使用的软件是我的一个软件, 后面更新时, 会提供接口, 供指定软件.
