//
//  WKWebViewController.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit
import WebKit

final class WKWebViewController: UIViewController, WKUIDelegate {
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        return webView
    }()
    
    private lazy var feedbackView = FeedbackView()
    
    private let urlRequest: URLRequest
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        super.loadView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(urlRequest)
    }
}

// MARK: WKNavigationDelegate
extension WKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        feedbackView.addFeedback(to: view, type: .loading)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        feedbackView.removeFromSuperview()
    }
}
