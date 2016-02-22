#!/usr/bin/python
#coding=utf-8

import urllib
import urllib2
import mimetools, mimetypes
import os, stat

class Callable:
    def __init__(self, anycallable):
        self.__call__ = anycallable

doseq = 1

class MultipartPostHandler(urllib2.BaseHandler):
    handler_order = urllib2.HTTPHandler.handler_order - 10 # needs to run first

    def http_request(self, request):
        data = request.get_data()
        if data is not None and type(data) != str:
            v_files = []
            v_vars = []
            try:
                 for(key, value) in data.items():
                     if type(value) == file:
                         v_files.append((key, value))
                     else:
                         v_vars.append((key, value))
            except TypeError:
                systype, value, traceback = sys.exc_info()
                raise TypeError, "not a valid non-string sequence or mapping object", traceback

            if len(v_files) == 0:
                data = urllib.urlencode(v_vars, doseq)
            else:
                boundary, data = self.multipart_encode(v_vars, v_files)
                contenttype = 'multipart/form-data; boundary=%s' % boundary
                if(request.has_header('Content-Type')
                   and request.get_header('Content-Type').find('multipart/form-data') != 0):
                    print "Replacing %s with %s" % (request.get_header('content-type'), 'multipart/form-data')
                request.add_unredirected_header('Content-Type', contenttype)

            request.add_data(data)
        return request

    def multipart_encode(vars, files, boundary = None, buffer = None):
        if boundary is None:
            boundary = "--1234567890"
        if buffer is None:
            buffer = ''
        for(key, value) in vars:
            buffer += '--%s\r\n' % boundary
            buffer += 'Content-Disposition: form-data; name="%s"' % key
            buffer += '\r\n\r\n' + value + '\r\n'
        for(key, fd) in files:
            file_size = os.fstat(fd.fileno())[stat.ST_SIZE]
            filename = fd.name.split('/')[-1]
            contenttype = mimetypes.guess_type(filename)[0] or 'application/octet-stream'
            buffer += '--%s\r\n' % boundary
            buffer += 'Content-Disposition: form-data; name="%s"; filename="%s"\r\n' % (key, filename)
            buffer += 'Content-Type: %s\r\n' % contenttype
            fd.seek(0)
            buffer += '\r\n' + fd.read() + '\r\n'
        buffer += '--%s--\r\n\r\n' % boundary
        return boundary, buffer
    multipart_encode = Callable(multipart_encode)
    https_request = http_request

def main(api_username,api_password,img_url,api_post_url,yzm_min='',yzm_max='',yzm_type='',tools_token=''):
    import tempfile

    validatorURL = api_post_url
    opener = urllib2.build_opener(MultipartPostHandler)

    if yzm_min == '' :
        yzm_min = '4'
    if yzm_max == '' :
        yzm_max = '4'

    def validateFile(url):
        temp = tempfile.mkstemp(suffix=".png")
        os.write(temp[0],opener.open(url).read())
        params = { "user_name"      : '%s' % api_username,
                   "user_pw"        : "%s" % api_password ,
                   "yzm_minlen"     : "%s" % yzm_min ,
                   "yzm_maxlen"     : "%s" % yzm_max ,
                   "yzmtype_mark"   : "%s" % yzm_type ,
                   "zztool_token"   : "%s" % tools_token ,
                   "upload"          : open(temp[1], "rb")
                 }
        print params
        print opener.open(validatorURL, params).read()

    validateFile(img_url)

if __name__=="__main__":
    main('seaify',
         '67c86225',
         'https://passport.58.com/validatecode?temp=123i1knr04o',
         "http://bbb4.hyslt.com/api.php?mod=php&act=upload",
         '4',
         '6',
         '',
         '')

    '''
    main() 参数介绍
    api_username    （API账号）             --必须提供
    api_password    （API账号密码）         --必须提供
    img_url         （需要打码的验证码URL）  --必须提供
    api_post_url    （API接口地址）         --必须提供
    yzm_min         （验证码最小值）        --可空提供
    yzm_max         （验证码最大值）        --可空提供
    yzm_type        （验证码类型）          --可空提供
    tools_token     （工具或软件token）     --可空提供
   '''
