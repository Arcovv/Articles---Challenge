# Articles---Challenge

## First, I want to declare: It's an iOS project using Swift, but I use some Local HTML files so maybe Github thinks it's a HTML type.

OK, let's begin.

![Example Gif](http://i.imgur.com/h4DyPl2.gif)

---

## The Process

This challenge asks me to using some HTML files when loading WKWebView. 

* First, using `NSBundle.mainBundle().pathForResource(_, ofType: _)` to get the file path. 
* Second, using `String(contentsOfFile: _, encoding: NSUTF8StringEncoding)` to get the HTML string.
* I'm not familiar with HTML/JS/CSS and other web programming languages. Acturally, I haven't written any web programming language before, so just went to [w3school](http://www.w3schools.com) and used when just learned. For convenience, I modified the lengthy script and add them by myself:

``` swift
var html = "<html>"
	html += "<head>"
	html += "<style>"
	html += "body { font-size: 18px; margin: 0px; padding: 0px; max-height: \(height)px; height: \(height)px; max-width: \(width)px; -webkit-column-width: \(width)px; -webkit-column-gap: 0px; }"
	// html += "#container { height: \(height)px; -webkit-column-width: \(width)px; -webkit-column-gap: 50px; background-color: yellow; }"
	html += "</style>"
	html += "</head>"
	html += "<body>"
	//html += "<div id=\"container\">"
	html += loadHTMLString
	//html += "</div>"
	html += "</body>"
	html += "</html>"
```

In above, I think the most thing are 
1. `max-height: \(height)px;` 
2. `height: \(height)px;` 
3. `max-width: \(width)px;` 
4. `-webkit-column-width: \(width)px;`
5. `margin: 0px;`
   
If you're not familiar with these, you will get puzzled and crazy all day. 😂

Do more practise about them!

Then, using `loadHTMLString(_, baseURL: _)` and enjoy!

> Sometime I think, alternative is using `webView.configuration.userContentController.addUserScript(script)` and `webView.configuration.userContentController.addScriptMessageHandler(self, name: "observe")` to inject Our script then follow `WKScriptMessageHandler` protocol to get the body text. At last show them in UILabel and UIScrollView or something... This will be more easily to page the article using animation like reading book. Maybe I will implement this in one day. You can see my method in `webViewScriptSetUp()` and comment in `WKScriptMessageHandler` protocol. Print it and you will get what I want.


* Care about UIScrollView in WkWebView and delegate UIScrollViewDelegate by `self`. You also must set `delegate = nil` when you out of the view controller, or you will get crash every time. 
* Use your Logic and add more gestures in scrollView. I implement when use tapping in 20% width left or right rect, the article will *paging*. Be care and should implement one `UIGestureRecognizerDelegate`. See more at line 222.
* I use a `PageLogic` class to help me calculate the page index in every article. And use ErrorType to throw and catch error. I also use singleton pattern and it's really interesting.
* KVO is really useful and I use it to observe the file loading status and what is the current page. Not to forget remove them in deinit.

This challenge gave me a revelation, which reminded me I should read and practice more iOS Fundation frameworks. It alse notice me I should learn more programming languages.

### **A long and long road, but a Passionate and Challenging future.**

Thanks for your reading.

Yue Jun

---

## Some Reference

* [UIWebView和WKWebView的使用及js交互](http://liuyanwei.jumppo.com/2015/10/17/ios-webView.html)
* [w3school](http://www.w3schools.com)
* [Programming iOS 9](http://shop.oreilly.com/product/0636920044352.do)
* [Hacking with Swift](https://www.hackingwithswift.com)

## LICENSE

The MIT License (MIT)

Copyright (c) 2016 YueJun_HSIEH

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.