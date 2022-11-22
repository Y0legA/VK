// AutorizeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

// Экран авторизации
final class AutorizeViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let tabBarIdentifier = "tabBarSegue"
    }

    // MARK: - Private IBoutlet

    @IBOutlet private var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Private Methods

    private func configure() {
        uploadToken()
    }

    private func uploadToken() {
        guard let url = createUrl() else { return }
        let request = URLRequest(url: url)
        webview.load(request)
    }

    private func createUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Url.scheme
        urlComponents.host = Url.host
        urlComponents.path = Url.path
        urlComponents.queryItems = [
            URLQueryItem(name: Url.clientId, value: Url.clientIdValue),
            URLQueryItem(name: Url.display, value: Url.displayValue),
            URLQueryItem(name: Url.redirectUrl, value: Url.redirectUrlValue),
            URLQueryItem(name: Url.scope, value: Url.scopeValue),
            URLQueryItem(name: Url.responseType, value: Url.responseTypeValue),
            URLQueryItem(name: Url.vName, value: Url.vValue)
        ]
        return urlComponents.url
    }
}

// WKNavigationDelegate
extension AutorizeViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url,
              url.path == Url.blankHtml,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: Url.ampersand)
            .map { $0.components(separatedBy: Url.equal) }.reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params[Url.token] else { return }
        Session.shared.token = token
        performSegue(withIdentifier: Constants.tabBarIdentifier, sender: self)
        decisionHandler(.cancel)
    }
}
