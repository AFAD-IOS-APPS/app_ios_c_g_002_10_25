//
//  WebViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 10/12/2025.
//

import UIKit
import WebKit

protocol WebViewProtocol: AnyObject {
    func updateBaseDomain(_ domain: String)
    func loadWebView(with request: URLRequest)
}

class WebViewController: UIViewController, WebViewProtocol {
    
    private let presenter: WebPresenter

    private var webView: WKWebView!
    
    private var baseDomain: String = ""
    private var redirectCaptured = false
    
    init(presenter: WebPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupWebView()
        
        Task {
            await presenter.viewDidLoad()
        }
    }

    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.preferences.javaScriptEnabled = true

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func updateBaseDomain(_ domain: String) {
        self.baseDomain = domain
    }
    
    func loadWebView(with request: URLRequest) {
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {

        guard
            let url = navigationAction.request.url,
            let host = url.host
        else {
            decisionHandler(.allow)
            return
        }

        if host == baseDomain {
            presenter.startMainFlow()
            decisionHandler(.cancel)
            return
        }

        if !redirectCaptured && host != baseDomain {
            presenter.savedURL = url.absoluteString
            redirectCaptured = true
        }

        decisionHandler(.allow)
    }
}

extension WebViewController: WKUIDelegate {
    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        let newWebView = WKWebView(frame: webView.frame, configuration: configuration)
        newWebView.navigationDelegate = self
        newWebView.uiDelegate = self

        let vc = UIViewController()
        vc.view = newWebView

        present(vc, animated: true)

        return newWebView
    }
}
