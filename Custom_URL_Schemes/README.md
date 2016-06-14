#Custom URL Schemes

http://www.idev101.com/code/Objective-C/custom_url_schemes.html

Open Safari:
type:  test://test   then the app will be opened.

Or we could call:
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"myappscheme://test/one?token=12345&domain=foo.com"]];