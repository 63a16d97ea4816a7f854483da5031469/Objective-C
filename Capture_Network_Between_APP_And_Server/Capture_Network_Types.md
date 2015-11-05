#Capture the Network between Server and App

##GET

GET /xxxxx/xxxxxxx/xxxxxxx-xxxxxxx/xxxxxxx/xxxxxxx/xxxxxxx  
Host  192.168.14.53  
If-Modified-Since Thu, 10 Sep 2015 06:18:12 GMT  
Accept-Encoding gzip, deflate  
Accept  application/json  
Cookie  app-skin=desktop  
Accept-Language en-US  
Connection  keep-alive  
User-Agent  xxxxxxxxxxxxxxx CFNetwork/711.1.12 Darwin/13.4.0  



Response:

HTTP/1.1 200 OK  
Date: Mon, 14 Sep 2015 07:32:09 GMT  
Server: Apache  
x-frame-options: SAMEORIGIN  
SET-COOKIE: app-skin=desktop;Max-Age=63072000;path=/; HttpOnly  
Vary: Accept-Encoding  
Content-Encoding: gzip  
Keep-Alive: timeout=15, max=49998  
Connection: Keep-Alive  
Transfer-Encoding: chunked  
Content-Type: application/json;charset=UTF-8  

	{"returnCode":1}


------------------------------------------------------------------------------------------------------------------------------------------------

##POST

POST /xx/xxxx/xxx-xxxx/v2/xxxx/xxxxxxx HTTP/1.1  
Host: 192.168.114.53  
Authorization: Basic Y2hlZWWhvbmcudGVoQHN0ZXJPpYS5jb20uc2c6QWJjZGUxMjM=  
Accept-Encoding: gzip, deflate  
Content-Type: application/json  
Cookie: app-skin=desktop  
Accept-Language: en-US  
Accept: application/json  
Content-Length: 1314  
Connection: keep-alive  
User-Agent: APPxxxx/04 CFNetwork/711.1.12 Darwin/13.4.0  




Response:

HTTP/1.1 200 OK  
Date: Mon, 14 Sep 2015 07:34:13 GMT  
Server: Apache  
x-frame-options: SAMEORIGIN  
SET-COOKIE: app-skin=desktop;Max-Age=63072000;path=/; HttpOnly  
Set-Cookie: JSESSIONID=EE968E3EE2314F44DA7D4B0B8EF170B4.s45t05; Path=/yu/xxxxxxx/;HttpOnly
Vary: Accept-Encoding  
Content-Encoding: gzip  
Keep-Alive: timeout=15, max=49991  
Connection: Keep-Alive  
Transfer-Encoding: chunked  
Content-Type: application/json;charset=UTF-8  

	{"returnCode":1}



------------------------------------------------------------------------------------------------------------------------------------------------
##Capture WebView Load Another Web Page in Android
 
GET /xxxxx/xxxxxxx/xxxxxxx-xxxxxxx/xxxxxxx/xxxxxxx/xxxxxxx.html HTTP/1.1    
Host: 192.168.14.53  
Accept-Encoding: gzip, deflate  
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8  
Cookie: app-skin=desktop  
Connection: keep-alive  
Accept-Language: en-US  
User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 10_9_5 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B411  

Response:
HTTP/1.1 200 OK  
Date: Mon, 14 Sep 2015 07:46:48 GMT  
Server: Apache  
x-frame-options: SAMEORIGIN  
Accept-Ranges: bytes  
ETag: W/"1955-1441951349000"  
Last-Modified: Fri, 11 Sep 2015 06:02:29 GMT  
Cache-Control: max-age=1296000  
Expires: Tue, 29 Sep 2015 07:46:48 GMT  
Vary: Accept-Encoding  
Content-Encoding: gzip  
Set-Cookie: JSESSIONID=6298BD285EA8400174F38495A261CF24.s45t04;path=/xxxx/xxx; HttpOnly  
Content-Length: 755    
Keep-Alive: timeout=15, max=50000  
Connection: Keep-Alive  
Content-Type: text/html;charset=UTF-8  

	<!DOCTYPE HTML>
	<html>
	  <head>
	    <style type="text/css">
	      html, body {
	        width:100%;
	        height: 100%;
	        margin: 0px;
	        padding: 0px;
	      }
	    </style>
	    <script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>
	    <script type="text/javascript" src="../js/JavascriptBridge.js"></script>
	  </head>
	..............
	</html>


------------------------------------------------------------------------------------------------------------------------------------------------

##Insert the Authorization information into Header:

http://stackoverflow.com/questions/19102373/afnetworking-2-0-and-http-basic-authentication

AFNetworking 2.0 and HTTP Basic Authentication

	AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://examplewebsite.com"]];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"userName" password:@"password"];



------------------------------------------------------------------------------------------------------------------------------------------------







------------------------------------------------------------------------------------------------------------------------------------------------







------------------------------------------------------------------------------------------------------------------------------------------------







------------------------------------------------------------------------------------------------------------------------------------------------







------------------------------------------------------------------------------------------------------------------------------------------------







------------------------------------------------------------------------------------------------------------------------------------------------





