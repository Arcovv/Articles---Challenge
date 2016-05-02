/**
* Copyright (c) 2016 YueJun_HSIEH
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:

* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.

* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

import UIKit
import WebKit

private let leftProportionRect  = CGFloat(0.2)
private let rightProportionRect = CGFloat(1 - leftProportionRect)


enum PageDirection: Int {
	case ToLeft = -1
	case ToRight = 1
}

class DetailViewController: UIViewController {
	
	// MARK: - Properties
	
	var article: Article!
	
	var pageLogic: PageLogic!
	
	var oldOffset = CGPoint.zero
	
	var webView: WKWebView!
	
	var activity: UIActivityIndicatorView!
	
	var webScrollView: UIScrollView {
		return webView.scrollView
	}
	
	var screenBounds: CGRect {
		return UIScreen.mainScreen().bounds
	}
	
	// MARK: - IBOutlet
	
	@IBOutlet weak var pageIndex: UIBarButtonItem!
	
	// MARK: - View Life Cycle
	
	deinit {
		
		webView.removeObserver(self, forKeyPath: "loading")
		pageLogic.removeObserver(self, forKeyPath: "currentPage")
		activity.stopAnimating()
		print("\(String(self)) is deinit.")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = article.author
		
		
		webViewSetUp()
		activityIndicatorViewSetUp()
		webViewHTMLSetUp()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		pageLogic = PageLogic(maxPageCount: getMaxPageCount())
		pageLogic.addObserver(self, forKeyPath: "currentPage", options: [.New], context: nil)
		pageIndex.title = "1 / \(pageLogic.userShowMaxPageCount)"
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		webScrollView.delegate = nil
	}
	
	// MARK: - KVO
	
	override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
		
		guard let keyPath = keyPath else { return }
		guard let change = change else { return }
		
		switch keyPath {
		case "loading":
			if let val = change[NSKeyValueChangeNewKey] as? Bool {
				if val {
					self.activity.startAnimating()
				} else {
					self.activity.stopAnimating()
				}
			}
			
		case "currentPage":
			pageIndex.title = "\(pageLogic.userShowPage) / \(pageLogic.userShowMaxPageCount)"
			
		default:
			break
		}
	}
}

// MARK: - DetailViewController Set Up

extension DetailViewController {
	
	func webViewSetUp() {
		webView = WKWebView()
		webView.navigationDelegate = self
		
		webScrollView.delegate = self
		webScrollView.showsVerticalScrollIndicator = false
		webScrollView.alwaysBounceVertical = false
		webScrollView.pagingEnabled    = true
		webScrollView.minimumZoomScale = 1.0
		webScrollView.maximumZoomScale = 1.0
		//webScrollView.backgroundColor  = UIColor.greenColor()
		
		view.addSubview(webView)
		
		webView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints([
			NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: [], metrics: nil, views: ["webView": webView]),
			NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[webView]|", options: [], metrics: nil, views: ["webView": webView])].flatten().map{$0})
		
		tapGestureSetUp()
	}
	
	func activityIndicatorViewSetUp() {
		let act = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
		act.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
		self.activity = act
		webView.addSubview(act)
		act.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints([
			act.centerXAnchor.constraintEqualToAnchor(webView.centerXAnchor), // available(iOS 9.0, *)
			act.centerYAnchor.constraintEqualToAnchor(webView.centerYAnchor)
			])
		webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
	}
	
	func tapGestureSetUp() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.gestureAction(_:)))
		tapGesture.delegate = self
		view.addGestureRecognizer(tapGesture)
	}
	
	func gestureAction(gesture: UIGestureRecognizer) {
		
		let tapLocation = gesture.locationInView(view)
		
		let originY     = CGFloat(64)
		let rectSize    = CGSize(width: screenBounds.width * leftProportionRect,
		                         height: screenBounds.height - originY)
		
		let leftPageRect = CGRect(origin: CGPoint(x: 0,y: originY), size: rectSize)
		let rightPageRect = CGRect(origin: CGPoint(x: screenBounds.width * rightProportionRect,y: originY), size: rectSize)
		
		if CGRectContainsPoint(leftPageRect, tapLocation) {
			pageLogic.backPage() {[weak self] page in
				self?.pagingAnimation(page)
			}
			
			
		} else if CGRectContainsPoint(rightPageRect, tapLocation) {
			pageLogic.nextPage() { [weak self] page in
				self?.pagingAnimation(page)
			}
			
		} else {
			// Invoke Central Control Navigation
			//print("Middle Rect.")
		}
	}
	
	func getMaxPageCount() -> Int {
		return Int(webScrollView.contentSize.width / screenBounds.width) - 1
	}
	
	func pagingAnimation(toPage: Int) {
		let distance        = CGFloat(toPage) * (screenBounds.width)
		let translateOffset = CGPoint(x: distance ,
		                              y: webScrollView.contentOffset.y)
		webScrollView.setContentOffset(translateOffset, animated: true)
	}
}

// MARK: - UIGestureRecognizerDelegate

extension DetailViewController: UIGestureRecognizerDelegate {
	
	func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}

// MARK: - UIScrollViewDelegate

extension DetailViewController: UIScrollViewDelegate {
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		//print(#function)
		scrollView.contentOffset.y = 0 // Try to position below Navigation Bar
	}
	
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
		return nil // Prevent zooming automatically
	}
	
	func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		print(#function)
		oldOffset = webScrollView.contentOffset
	}
	
	func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		print(#function)
		if velocity.x > 0 {
			pageLogic.nextPage(nil)
		} else if velocity.x < 0 {
			pageLogic.backPage(nil)
		}
		print(pageLogic.currentPage)
	}
	
	func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
		
		// This will happen when setContentOffset
	}
}

// MARK: - WKNavigationDelegate

extension DetailViewController: WKNavigationDelegate {
	
	func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		
	}
	
	func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
		
	}
	
	func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
		
	}
	
	func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
		print(#function)
		print(error.description)
	}
}

// MARK: - Web View Setting

extension DetailViewController {
	
	func webViewHTMLSetUp() {
		
		let path = Articles.single().getPath(article)
		let loadHTMLString = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
		
		let width = screenBounds.width
		let height = screenBounds.height - 64
		
		var html = "<html>"
		html += "<head>"
		html += "<style>"
		html += "body { font-size: 18px; margin: 0px; padding: 0px; max-height: \(height)px; height: \(height)px; max-width: \(width)px; -webkit-column-width: \(width)px; -webkit-column-gap: 0px; }"
		//        html += "#container { height: \(height)px; -webkit-column-width: \(width)px; -webkit-column-gap: 50px; background-color: yellow; }"
		html += "</style>"
		html += "</head>"
		html += "<body>"
		//html += "<div id=\"container\">"
		html += loadHTMLString
		//html += "</div>"
		html += "</body>"
		html += "</html>"
		
		webView.loadHTMLString(html, baseURL: nil)
		webViewScriptSetUp()
	}
	
	func webViewScriptSetUp() {
		let js = "window.webkit.messageHandlers.observe.postMessage(document.body.innerText);"
		let script = WKUserScript(source: js, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
		
		webView.configuration.userContentController.addUserScript(script)
		webView.configuration.userContentController.addScriptMessageHandler(self, name: "observe")
	}
}

// MARK: - WKScriptMessageHandler

extension DetailViewController: WKScriptMessageHandler {
	func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
		/* Get all the body text. */
		// let string = message.body as! String
		// print(string)
	}
}