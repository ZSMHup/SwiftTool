//
//  WebViewContainer.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/8/28.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import WebKit

class WebViewContainer: UIView {

    var title: (String) -> Void = { _ in }
    
    let configuration: WKWebViewConfiguration = {
        var source = """
            var meta = document.createElement('meta');
            meta.setAttribute('name', 'viewport');
            meta.setAttribute('content', 'width=device-width, initial-scale=1, maximum-scale=1');
            document.getElementsByTagName('head')[0].appendChild(meta);
            """
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentCtrl = WKUserContentController()
        userContentCtrl.addUserScript(userScript)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentCtrl
        return configuration
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: bounds, configuration: configuration)
        webView.scrollView.backgroundColor = UIColor.globalBackground
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        return webView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 2))
        progressView.progressTintColor = UIColor.theme
        progressView.trackTintColor = UIColor.clear
        progressView.isUserInteractionEnabled = false
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        addSubviews()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.navigationDelegate = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        webView.frame = bounds
        progressView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 2)
    }
    
    private func addSubviews() {
        addSubview(webView)
        addSubview(progressView)
    }
    
    private func showProgressView(visible: Bool = true, animated: Bool = true) {
        UIView.animate(withDuration: 0.25) {
            self.progressView.alpha = visible ? 1 : 0
        }
    }
    
    public func load(url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.progressView.transform = .identity
                }, completion: { (finished) in
                    self.showProgressView(visible: false)
                })
            }
        }
    }
}

extension WebViewContainer: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showProgressView()
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        bringSubviewToFront(progressView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showProgressView(visible: false)
        title(webView.title ?? "")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showProgressView(visible: false)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
}
